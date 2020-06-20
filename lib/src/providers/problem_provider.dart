import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/models/openproblem.dart';
import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';

class ProblemProvider {
  static final _endpointProblems = "${api_base_url}problem";
  static final _endPointReplayProblems = "${api_base_url}problem/replay";
  static final _endpointOpenProblems = "${api_base_url}problem-open";
  static final _endpointSolvedProblems = "${api_base_url}problem-solved";
  static final _endpointClosedProblems = "${api_base_url}problem-close";
  static final Dio _dio = Dio();

  static Future<ProblemResponse> getProblems() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpointProblems);
      return ProblemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return ProblemResponse.withError('$error');
    }
  }

  static Future<dynamic> postDataToProblem(Map postData) async {
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
      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  static Future<dynamic> postDataToProblemDiscussion(
      int postId, Map postData, String userType) async {
    var token = await SharedPrefProvider.getString('access_token');
    print(token);
    print(postData);
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    if (userType == "user") {
      try {
        Response response = await _dio
            .post(_endpointProblems + '/' + postId.toString(), data: postData);
        print(response);
        print(postId);
        return response.data;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return error;
      }
    } else {
      try {
        Response response = await _dio.post(
            _endPointReplayProblems + '/' + postId.toString(),
            data: postData);
        print(response);
        print(postId);
        return response.data;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return error;
      }
    }
  }

  static Future<dynamic> getDiscussions(int postId) async {
    var token = await SharedPrefProvider.getString('access_token');
    print(token);
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response =
          await _dio.get(_endpointProblems + '/' + postId.toString());
      print(response);
      return DiscussionResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  static Future<dynamic> deleteDataFromProblems(Map postData) async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.delete(_endpointProblems, data: postData);
      print(response);
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  static Future<dynamic> getOpenProblems() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpointOpenProblems);
      print(response);
      return OpenProblemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  static Future<dynamic> getSolvedProblems() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpointSolvedProblems);
      print(response);
      return OpenProblemResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  static Future<dynamic> markAsSolved(int problemId) async {
    var token = await SharedPrefProvider.getString('access_token');

    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    try {
      Response response =
          await _dio.get(_endpointClosedProblems + '/' + problemId.toString());
      print(response);
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }
}
