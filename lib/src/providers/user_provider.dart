
import 'package:bestaid/config/strings.dart';
import 'package:bestaid/models/user.dart';
import 'package:bestaid/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';

class UserProvider{
  static final String _endpoint = "${api_base_url}user";
  static final Dio _dio = Dio();

  static Future<UserResponse> getUser() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  static Future<UserResponse> postUserUpdatedData(Map updatedData) async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.post(_endpoint, data: updatedData);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

}