

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:dio/dio.dart';

class RegistrationProvider {
  static final _endpoint = "${api_base_url}register";
  static final _dio = Dio();

  static Future<dynamic> postRegistrationInfo(Map registrationInfo) async{
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
    };

    try {
      Response response = await _dio.post(_endpoint, data: registrationInfo);
//      var token = TokenResponse.fromJson(response.data);
//      SharedPrefProvider.setString('access_token', token.token);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }
  }