import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/services_locator.dart';
import '../remote/api_constance.dart';

class DioFinalHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Authorization': 'Bearer ${sl<SharedPreferences>().get('token')}',
          'Content-Type': 'application/json',
        },
      ),
    );


  }

  static Future<dynamic> postData({
    required String method,
    required Object data,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        'Authorization': 'Bearer ${sl<SharedPreferences>().get('token')}',
        'Content-Type': 'application/json',
      },
    );
    return await dio.post(
      method,
      data: data,
    );
  }

  static Future<dynamic> getData({
    required String method,
    Object? query,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        'Authorization': 'Bearer ${sl<SharedPreferences>().get('token')}',
        'Content-Type': 'application/json',
      },
    );
    return await dio.get(
      method,
      data: query,
    );
  }

  static Future<dynamic> putData({
    required String method,
    required Object data,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        'Authorization': 'Bearer ${sl<SharedPreferences>().get('token')}',
        'Content-Type': 'application/json',
      },
    );
    return await dio.put(
      method,
      data: data,
    );
  }

  static Future<dynamic> patchData({
    required String method,
    required Object data,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        'Authorization': 'Bearer ${sl<SharedPreferences>().get('token')}',
        'Content-Type': 'application/json',
      },
    );
    return await dio.patch(
      method,
      data: data,
    );
  }

  static Future<dynamic> deleteData({
    required String method,
    String? token,
  }) async {
    return await dio.delete(
      method,
    );
  }
}
