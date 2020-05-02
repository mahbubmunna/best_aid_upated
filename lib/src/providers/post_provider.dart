

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/post.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';

class PostProvider{
  static final _endpointProblems = "${api_base_url}problem";
  static final _endpointPost = "${api_base_url}post";
  static final Dio _dio = Dio();

  static Future<PostResponse> getPost() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpointPost);
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return PostResponse.withError('$error');
    }
  }

  static Future<PostResponse> getProblems() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpointProblems);
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return PostResponse.withError('$error');
    }
  }

  static Future<dynamic> postDataToProblem(Map postData) async{
    var token = await SharedPrefProvider.getString('access_token');
    print(token);
    print(postData);
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.post(_endpointProblems, data: postData);
      print(response);
      return response;
    } catch (error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }

  }

  static Future<dynamic> deleteDataFromPost(Map postData) async{
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.delete(_endpointPost, data: postData);
      print(response);
      return response;
    } catch (error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }

  }


}