import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/services_locator.dart';
import '../../authentication/models/user_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) {
    return BlocProvider.of(context);
  }

  File? imageProfileCover;
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

  Future<void> updateCoverProfile() async {
    emit(UpdateUserLoadingSettingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfileCover!.path).pathSegments.last}')
        .putFile(imageProfileCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: userModel!.name,
          phone: userModel!.phone,
          bio: userModel!.bio!,
          image: userModel!.image,
          cover: value,
        );
        emit(UpdateUserSuccessSettingState());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorSettingState(onError.toString()));
      });
    });
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    emit(UpdateUserLoadingSettingState());
    userModel = UserModel(
      email: userModel!.email,
      name: name,
      phone: phone,
      uId: sl<SharedPreferences>().getString('uId'),
      isEmailVerified: false,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .update(userModel!.toMap())
        .then((value) {
      getUserData();
      print(bio.toString());
      emit(UpdateUserSuccessSettingState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateUserErrorSettingState(onError.toString()));
    });
  }
  var picker = ImagePicker();

  Future<void> getProfileCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageProfileCover = File(pickerFile.path);
      emit(ProfileImageCoverSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImageCoverErrorState());
    }
  }
  File? imageProfile;

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageProfile = File(pickerFile.path);
      emit(ProfileImageCoverSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImageCoverErrorState());
    }
  }

  Future<void> updateProfile() async {
    emit(UpdateUserLoadingSettingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            name: userModel!.name!,
            phone: userModel!.phone!,
            bio: userModel!.bio!,
            image: value,
            cover: userModel!.cover);
        emit(UpdateUserSuccessSettingState());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorSettingState(onError.toString()));
      });
    });
  }

}
