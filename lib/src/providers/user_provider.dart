import 'dart:io';

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UserProvider {
  static final String _endpoint = "${api_base_url}login";
  static final String _userEndpoint = "${api_base_url}user";
  static final String _registerEndpoint = "${api_base_url}register";
  static final Dio _dio = Dio();

  static Future<UserResponse> getUser() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_userEndpoint);
      print(response.data);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  static Future<UserResponse> updateUserData(Map updatedUserData) async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      await _dio.post(_userEndpoint, data: updatedUserData);
      return getUser();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  static Future<UserResponse> postLoginData(Map loginData) async {
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
    };

    try {
      Response response = await _dio.post(_endpoint, data: loginData);
//      var token = TokenResponse.fromJson(response.data);
//      SharedPrefProvider.setString('access_token', token.token);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  static Future<UserResponse> postRegisterData(Map registerData) async {
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
    };

    try {
      Response response =
      await _dio.post(_registerEndpoint, data: registerData);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

}
