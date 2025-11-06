import 'dart:convert';

import 'package:boopbook/core/network/local/dio.dart';
import 'package:boopbook/feature/authentication/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/remote/api_constance.dart';
import '../../../../core/services/services_locator.dart';

part 'ath_state.dart';

class AthCubit extends Cubit<AthState> {
  AthCubit() : super(AthInitial());

  static AthCubit get(context) {
    return BlocProvider.of(context);
  }

  var emailController = TextEditingController();
  var restController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  Future<void> signIn({
    required String pass,
    required String email,
  }) async {
    emit(SignInLoading());
    try {
      final response = await Dio().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAdWjuwvbWUbF7RSlb7bYr5mFJv4oAIAbs',
        data: {
          'email': email,
          'password': pass,
        },
      );
      print(response.data);
      emit(SignInSuccess(response.data['localId']));
    } on DioException catch (e) {
      print(e.response!.data['error']);
      emit(SignInError(e.response!.data['error']['message'].toString()));
    }
  }

  Future<void> signUp({
    required String pass,
    required String phone,
    required String email,
    required String name,
  }) async {
    emit(SignUpLoading());
    try {
      final response = await Dio().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${ApiConstance.webKey}',
        data: {
          'email': email,
          'password': pass,
          'returnSecureToken': true,
        },
      );
      sl<SharedPreferences>().setString('token', response.data['idToken']);

      print(response.data);
      createUser(
        email: email,
        phone: phone,
        name: name,
        uId: response.data['localId'],
      );
      emit(SignUpSuccess(response.data['localId']));
    } on DioException catch (e) {
      emit(SignUpError(e.response!.data['error']['message'].toString()));
    }
  }

  Future<void> createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) async {
    emit(CreateUserLoading());
    try {
      final Map<String, dynamic> dataToAdd = {
        'fields': {
          'cover': {
            'stringValue': 'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api'
          },
          'isEmailVerified': {
            'booleanValue': false,
          },
          'bio': {
            'stringValue': '....',
          },
          'email': {
            'stringValue': email,
          },
          'uId': {
            'stringValue': uId,
          },
          'name': {
            'stringValue': name,
          },
          'phone': {
            'stringValue': phone,
          },
          'image': {
            'stringValue': 'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api',
          },
        },
      };

      DioFinalHelper.patchData(
        method: 'users/$uId',
        data: json.encode(dataToAdd),
      );
      emit(CreateUserSuccess(uId));
    } on DioException catch (e) {
      print(e.response!.data['error']['message'].toString());
      emit(CreateUserError(e.response!.data['error']['message'].toString()));
    }
  }

  Future<void> restPassword({
    required String email,
  }) async {
    emit(RestPasswordLoading());
    try {
      final response = await Dio().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyAdWjuwvbWUbF7RSlb7bYr5mFJv4oAIAbs',
        data: {
          'email': email,
          "requestType": "PASSWORD_RESET",
        },
      );
      print(response.statusMessage);
      emit(RestPasswordSuccess());
    } on DioException catch (e) {
      print(e.response!.data['error']);
      emit(RestPasswordError(e.response!.data['error']['message'].toString()));
    }
  }
}
