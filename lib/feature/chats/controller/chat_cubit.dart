import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:boopbook/feature/reals/view/followers_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../core/services/services_locator.dart';
import '../model/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) {
    return BlocProvider.of(context);
  }

  List<MessageModel> messagesList = [];

  void getMessages(FollowerModel userDataModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .collection('chat')
        .doc(userDataModel.uId)
        .collection('message')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((value) {
      messagesList = [];
      for (var element in value.docs) {
        messagesList.add(MessageModel.fromJson(element.data()));
      }

      debugPrint(messagesList.length.toString());

      emit(SocialGetMessagesSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
    String? video,
  }) {
    MessageModel massageModel = MessageModel(
      message: text,
      senderId: sl<SharedPreferences>().getString('uId')!,
      receiverId: receiverId,
      time: dateTime,
      image: image ?? '',
      video: video ?? '',
    );
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(sl<SharedPreferences>().getString('uId'))
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(sl<SharedPreferences>().getString('uId'))
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  var picker = ImagePicker();

  File? chatImage;
  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> sendChatImage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          dateTime: dateTime,
          text: text,
          image: value,
        );
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates());
      });
    });
  }

  void UplaodVideochat({
    String? chatvideo,
    required String reciverid,
    required String text,
    required String datatime,
  }) {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(VideoChat!.path).pathSegments.last}')
        .putFile(VideoChat!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
            receiverId: reciverid,
            dateTime: datatime,
            text: text,
            video: value);
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((error) {
        print(error.toString());
        emit(UpdateUserErrorHomePageStates());
      });
    }).catchError((onError) {});
  }
  File? VideoChat;

  Future<void> uploadvideochat() async {
    final pickerfile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickerfile != null) {
      VideoChat = File(pickerfile.path);
      print(VideoChat.toString());
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
    }
  }


  void removePostImage() {
    chatImage = null;
    VideoChat = null;

    emit(SocialRemovePostImageState());
  }
}
