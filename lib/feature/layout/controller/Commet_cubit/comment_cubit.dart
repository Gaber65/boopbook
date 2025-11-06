import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart';
import '../../model/comment_model.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  static CommentCubit get(context) {
    return BlocProvider.of(context);
  }

  Future createComment({
    required String comment,
    required String postId,
    required String image,
    required String name,
    required String collection,
  }) async {
    String dataTime = DateTime.now().toString();
    emit(CreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
      name: name,
      uid: sl<SharedPreferences>().getString('uId'),
      image: image,
      text: comment,
      dataTime: dataTime,
    );
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState());
    });
  }

  List<CommentModel> commentPost = [];
  List<String> commentIds = [];

  void getComment({
    required String postId,
    required String collection,
  }) {
    emit(GetCommentLoadingState());
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      commentPost.clear();
      for (var element in event.docs) {
        commentPost.add(CommentModel.fromJson(element.data()));
        commentIds.add(element.id);
      }
      emit(GetCommentSuccessState());
    }).onError((handleError) {
      print(handleError.toString());
      emit(GetCommentErrorState());
    });
  }

  void getSubComment({
    required String postId,
    required String commentId,
    required String collection,
  }) {
    emit(GetCommentLoadingState());
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('subComments')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      commentPost.clear();
      for (var element in event.docs) {
        commentPost.add(CommentModel.fromJson(element.data()));
      }
      emit(GetCommentSuccessState());
    }).onError((handleError) {
      print(handleError.toString());
      emit(GetCommentErrorState());
    });
  }

  void createSubComment({
    required String comment,
    required String commentId,
    required String postId,
    required String image,
    required String name,
    required String collection,
  }) {
    String dataTime = DateTime.now().toString();
    emit(CreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
      name: name,
      uid: sl<SharedPreferences>().getString('uId'),
      image: image,
      text: comment,
      dataTime: dataTime,
    );
    FirebaseFirestore.instance
        .collection(collection)
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('subComments')
        .add(commentModel.toMap())
        .then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState());
    });
  }

  Future addCommentList({
    required String postId,
    required String id,
    required List<dynamic> postComments,
    required String collection,
  }) async {
    postComments.add(id);
    await FirebaseFirestore.instance.collection(collection).doc(postId).update({
      "postComments": postComments,
    }).then((value) {
      emit(SocialLikePostStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikePostStateError());
    });
  }
}
