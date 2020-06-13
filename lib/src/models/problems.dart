import 'package:bestaid/src/models/user.dart';

import 'discussion.dart';

class ProblemResponse {
  List<Problem> posts;
  String error;

  ProblemResponse.fromJson(Map<String, dynamic> json)
      : posts = ((json['problem'] as List)
            .map((item) => Problem.fromJson(item))).toList(),
        error = "";

  ProblemResponse.withError(String errorValue)
      : posts = List(),
        error = errorValue;
}
