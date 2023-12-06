import 'package:bloc/bloc.dart';
import 'package:boopbook/feature/layout/model/story_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/local/dio.dart';
import '../../../../core/services/services_locator.dart';
import '../../../authentication/models/user_model.dart';
import '../../model/post_model.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsInitial());
  static FeedsCubit get(context) {
    return BlocProvider.of(context);
  }

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      Response result = await Dio().get(
          'https://firestore.googleapis.com/v1/projects/socail-app-99ae9/databases/(default)/documents/users/${sl<SharedPreferences>().getString('uId')}');
      userModel = UserModel.fromJson(result.data['fields']);
      print(userModel!.image!.values.first);
      emit(GetUserDataSuccess());
    } on DioException catch (e) {
      print(e.response);
      emit(GetUserDataError());
    }
  }

  List<StoryModel> storyModel = [];
  Future<void> getStoryData() async {
    emit(GetStoryLoading());
    try {
      Response result = await Dio().get(
          'https://firestore.googleapis.com/v1/projects/socail-app-99ae9/databases/(default)/documents/story');
      List<dynamic> jsonData = result.data['documents'];
      storyModel = jsonData.map((data) => StoryModel.fromJson(data)).toList();
      emit(GetStorySuccess());
    } on DioException catch (e) {
      print(e.response);
      emit(GetStoryError());
    }
  }

  List<PostModel> postsModel = [];
  Future<void> getPostsData() async {
    emit(GetPostsLoading());
    try {
      Response result = await Dio().get('https://firestore.googleapis.com/v1/projects/socail-app-99ae9/databases/(default)/documents/posts');
      List<dynamic> jsonData = result.data['documents'];
      postsModel = jsonData.map((data) => PostModel.fromJson(data)).toList();
      emit(GetPostsSuccess());
    } on DioException catch (e) {
      print(e.response);
      emit(GetPostsError());
    }
  }
}
