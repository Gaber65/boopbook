import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boopbook/feature/layout/model/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/local/dio.dart';
import '../../../../core/services/services_locator.dart';
import '../../../authentication/models/user_model.dart';
import '../../../reals/view/followers_model.dart';
import '../../model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(FeedsInitial());

  static CommunityCubit get(context) {
    return BlocProvider.of(context);
  }

  var textController = TextEditingController();
  UserModel? userModel;

  Future<void> getUserData() async {
    emit(GetUserDataLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .snapshots()
        .listen((event) {
          print(event.data());
      userModel = UserModel.fromJson(event.data()!);
      emit(GetUserDataSuccess());
    }).onError((handleError) {
      emit(GetUserDataError());
    });
  }

  List<StoryModel> storyModel = [];
  List<String> storyId = [];

  Future<void> getStoryData() async {
    emit(GetStoryLoading());
    FirebaseFirestore.instance.collection('story').snapshots().listen((event) {
      storyModel.clear();
      storyId.clear();
      for (var e in event.docs) {
        print(e.data());
        storyId.add(e.id);
        storyModel.add(StoryModel.fromJson(e.data()));
        print(postsModel);
      }
      emit(GetStorySuccess());
    }).onError((handleError) {
      emit(GetStoryError());
    });
  }

  List<PostModel> postsModel = [];
  List<String> postIds = [];

  Future<void> getPostsData() async {
    emit(GetPostsLoading());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      postsModel.clear();
      postIds.clear();
      for (var e in event.docs) {
        print(e.data());
        postIds.add(e.id);
        postsModel.add(PostModel.fromJson(e.data()));
        print(postsModel);
      }
      emit(GetPostsSuccess());
    }).onError((handleError) {
      emit(GetPostsError());
    });
  }

  Future<void> removePost(String? postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialSuccessRemovePostState());
      print('Deleted');
    }).catchError((onError) {
      emit(SocialErrorRemovePostState());
    });
  }

  Future<void> removeStory(String? postId) async {
    await FirebaseFirestore.instance
        .collection('story')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialSuccessRemovePostState());
      print('Deleted');
    }).catchError((onError) {
      emit(SocialErrorRemovePostState());
    });
  }

  String? currentPosition;
  double? latitude;
  double? longitude;

  getCurrentLocation() async {
    var status = await Permission.location.request();
    emit(RequestLocationPermission());
    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition = '${position.latitude},${position.longitude}';
        latitude = position.latitude;
        longitude = position.longitude;
        emit(GetStorySuccess());
      } catch (e) {
        print("Error: $e");
        emit(GetLocationError());
      }
    } else {
      print("Location permission denied");
    }
  }

  var picker = ImagePicker();
  File? imageFile;

  Future pickImage({
    required ImageSource source,
  }) async {
    final pickerFile = await picker.pickImage(source: source);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);

      emit(ImageSelectedState(imageFile!));
    } else {
      print('No image selected');
      emit(NoImageSelectedState());
    }
  }

  Future pickVideo({
    required ImageSource source,
  }) async {
    final pickerFile = await picker.pickVideo(source: source);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
      emit(ImageSelectedState(imageFile!));
    } else {
      print('No image selected');
      emit(NoImageSelectedState());
    }
  }

  void clearImage() {
    imageFile = null;
    currentPosition = null;
    emit(NoImageSelectedState());
  }

  bool showBottom = false;

  Future changeBottom() async {
    showBottom = !showBottom;
    print(showBottom);
    emit(NoImageSelectedState());
  }

  bool? ifImage;

  Future getFileType(String filePath) async {
    List<String> parts = filePath.split('.');
    String extension = parts.isNotEmpty ? parts.last.toLowerCase() : '';
    if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png' ||
        extension == 'gif') {
      ifImage = true;
      print(ifImage);
      emit(ImageSelectedState(imageFile!));
    } else {
      ifImage = false;
      print(ifImage);
      emit(ImageSelectedState(imageFile!));
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImageToFirebase({
    required String text,
  }) async {
    String dateTime = DateTime.now().toString();
    emit(UploadImageToFireStateLoading());
    if (imageFile != null) {
      storage
          .ref()
          .child('posts/${Uri.file(imageFile!.path).pathSegments.last}')
          .putFile(imageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          createPost(
            text: text,
            dateTime: dateTime,
            filePost: value,
          );
          emit(UploadImageToFireStateSuccess());
        }).catchError((onError) {
          print(onError.toString());
          emit(UploadImageToFireStateError());
        });
      });
    } else if (latitude != null && longitude != null) {
      createPost(
        text: text,
        dateTime: dateTime,
        latitude: latitude!,
        longitude: longitude!,
      );
      emit(CreatePostToFireStateSuccess());
    } else {
      createPost(
        text: text,
        dateTime: dateTime,
      );
    }
  }

  Future<void> uploadStoryToFirebase() async {
    String dateTime = DateTime.now().toString();
    emit(UploadImageToFireStateLoading());
    if (imageFile != null) {
      storage
          .ref()
          .child('story/${Uri.file(imageFile!.path).pathSegments.last}')
          .putFile(imageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          StoryModel model = StoryModel(
            uId: sl<SharedPreferences>().getString('uId'),
            image: userModel!.image!,
            name: userModel!.name!,
            dateTime: dateTime,
            object: value,
          );
          FirebaseFirestore.instance.collection('story').add(model.toMap());
          emit(UploadImageToFireStateSuccess());
        }).catchError((onError) {
          print(onError.toString());
          emit(UploadImageToFireStateError());
        });
      });
    }
  }

  Future createPost({
    String? filePost,
    double? longitude,
    double? latitude,
    required String text,
    required String dateTime,
  }) async {
    emit(CreatePostToFireStateLoading());
    PostModel model = PostModel(
      text: text,
      name: userModel!.name,
      image: userModel!.image!,
      uId: userModel!.uId!,
      dateTime: dateTime,
      longitude: longitude ?? '',
      latitude: latitude ?? '',
      postComments: List.empty(),
      postLikes: List.empty(),
      video: ifImage != null
          ? ifImage == true
              ? ''
              : filePost
          : '',
      postImage: ifImage != null
          ? ifImage == false
              ? ''
              : filePost
          : '',
    );

    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostToFireStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(CreatePostToFireStateError());
    });
  }

  Future addLike({
    required String postId,
    required int index,
    required String id,
    required List<dynamic> postLikes,
  }) async {
    postLikes.add(id);
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      "postLikes": postLikes,
    }).then((value) {
      emit(SocialLikePostStateSuccess());
    }).catchError((onError) {
      print(onError!.toString());
      emit(SocialLikePostStateError());
    });
  }

  Future removeLike({
    required String postId,
    required int index,
    required String id,
    required List<dynamic> postLikes,
  }) async {
    postLikes.remove(id);
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      "postLikes": postLikes,
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
