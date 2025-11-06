import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boopbook/feature/layout/model/post_model.dart';
import 'package:boopbook/feature/reals/view/followers_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/services_locator.dart';
import '../../authentication/models/user_model.dart';

part 'reals_state.dart';

class RealsCubit extends Cubit<RealsState> {
  RealsCubit() : super(RealsInitial());

  static RealsCubit get(context) {
    return BlocProvider.of(context);
  }

  List<PostModel> realsModel = [];
  List<String> realsIdes = [];
  Future<void> getRealsData() async {
    emit(GetRealsLoading());
    FirebaseFirestore.instance
        .collection('reals')
        .orderBy(
          'dateTime',
          descending: false,
        )
        .snapshots()
        .listen((event) {
      realsIdes.clear();
      realsModel.clear();
      for (var e in event.docs) {
        print(e.data());
        realsIdes.add(e.id);
        realsModel.add(PostModel.fromJson(e.data()));
      }
      emit(GetRealsSuccess());
    }).onError((handleError) {
      emit(GetRealsSuccess());
    });
  }

  var picker = ImagePicker();
  File? imageFile;
  Future pickVideo({
    required ImageSource source,
  }) async {
    final pickerFile = await picker.pickVideo(source: source);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
      emit(ImageSelectedState());
    } else {
      print('No image selected');
      emit(NoImageSelectedState());
    }
  }

  void clearImage() {
    imageFile = null;
    emit(NoImageSelectedState());
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(GetUserDataLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromJson(event.data()!);
      emit(GetUserDataSuccess());
    }).onError((handleError) {
      emit(GetUserDataError());
    });
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadStoryToFirebase({
    required String text,
  }) async {
    String dateTime = DateTime.now().toString();
    emit(UploadVideoToFireStateLoading());
    if (imageFile != null) {
      storage
          .ref()
          .child('video/${Uri.file(imageFile!.path).pathSegments.last}')
          .putFile(imageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          PostModel model = PostModel(
            uId: sl<SharedPreferences>().getString('uId'),
            image: userModel!.image!,
            name: userModel!.name,
            dateTime: dateTime,
            video: value,
            latitude: '',
            text: text,
            longitude: '',
            postImage: '',
            postComments: List.empty(),
            postLikes: List.empty(),
          );
          FirebaseFirestore.instance.collection('reals').add(model.toMap());
          emit(UploadImageToFireStateSuccess());
        }).catchError((onError) {
          print(onError.toString());
          emit(UploadImageToFireStateError());
        });
      });
    } else {
      print('Noooooooooooooooooooooooooooooooo');
    }
  }

  Future addLike({
    required String realsId,
    required String id,
    required List<dynamic> postLikes,
  }) async {
    postLikes.add(id);
    await FirebaseFirestore.instance.collection('video').doc(realsId).update({
      "postLikes": postLikes,
    }).then((value) {
      emit(SocialLikePostStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikePostStateError());
    });
  }

  Future removeLike({
    required String realsId,
    required String id,
    required List<dynamic> postLikes,
  }) async {
    postLikes.remove(id);
    await FirebaseFirestore.instance.collection('video').doc(realsId).update({
      "postLikes": postLikes,
    }).then((value) {
      emit(SocialLikePostStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikePostStateError());
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
      emit(SocialLikePostStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikePostStateError());
    });
  }

  List<FollowerModel> followerModel = [];
  Future getFollow() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .collection('follows')
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        followerModel.add(FollowerModel.fromJson(element.data()));
      });
      emit(SocialLikePostStateSuccess());
    }).onError((onError) {
      print(onError!.toString());
    });
  }
}
