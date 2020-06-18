import 'discussion.dart';

class ProblemResponse {
  Problem problem;

  ProblemResponse({this.problem});

  ProblemResponse.fromJson(Map<String, dynamic> json) {
    problem =
        json['problem'] != null ? new Problem.fromJson(json['problem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.problem != null) {
      data['problem'] = this.problem.toJson();
    }
    return data;
  }
}
