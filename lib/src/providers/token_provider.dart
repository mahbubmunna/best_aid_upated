

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/models/token.dart';
import 'package:dio/dio.dart';


class TokenProvider{
  static final _endPoint = "${api_base_url}login";
  static final _dio = Dio();

  static Future<Token> getToken(Map loginInfo) async {
    _dio.options.contentType = Headers.formUrlEncodedContentType;
    try {
      Response response = await _dio.post(_endPoint, data: loginInfo);
      if (response.data['results'] == null){
        return Token.withError('Invalid credential');
      } else {
        return Token.fromJson(response.data);
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Token.withError("$error");
    }
  }

}