

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/token.dart';
import 'package:dio/dio.dart';


class TokenProvider{
  static final _endPointLogin = "${api_base_url}login";
  static final _endPointRegister = "${api_base_url}register";
  static final _dio = Dio();

  static Future<TokenResponse> getToken(Map loginInfo) async {
   // _dio.options.contentType = Headers.formUrlEncodedContentType;
    try {
      Response response;
      if (loginInfo.length == 4) response = await _dio.post(_endPointRegister, data: loginInfo);
      else response = await _dio.post(_endPointLogin, data: loginInfo);
      if (response.data['access_token'] == null){
        return TokenResponse.withError('Invalid credential');
      } else {
        return TokenResponse.fromJson(response.data);
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TokenResponse.withError("$error");
    }
  }

}