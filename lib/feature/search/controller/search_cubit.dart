import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/services_locator.dart';
import '../../authentication/models/user_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) {
    return BlocProvider.of(context);
  }

  var textController = TextEditingController();
  List<UserModel> allUser = [];
  void getAllUserData(String searchName) async {
    emit(GetAllUserLoadingSearchState());
    FirebaseFirestore.instance
        .collection('users')
        .where(
          'name',
          isGreaterThanOrEqualTo: searchName,
        )
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        allUser.add(UserModel.fromJson(element.data()));
        print(allUser);
      }
      emit(GetAllUserSuccessSearchState());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorSearchState());
    });
  }

  Future follow({
    required String image,
    required String uId,
    required String name,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .collection('follows')
        .doc(uId)
        .set({
      "image": image,
      'uId': uId,
      "name": name,
    }).then((value) {
      emit(SocialLikeSearchStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikeSearchStateError());
    });
  }
  void nameIsEmpty(String name){
    textController.text = name;
    emit(SocialLikeSearchStateSuccess());
  }
}
