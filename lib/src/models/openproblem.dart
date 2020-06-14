import 'package:bestaid/src/models/discussion.dart';

class OpenProblemResponse {
  List<Problem> problem;

  OpenProblemResponse({this.problem});

  OpenProblemResponse.fromJson(Map<String, dynamic> json) {
    if (json['problem'] != null) {
      problem = new List<Problem>();
      json['problem'].forEach((v) {
        problem.add(new Problem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.problem != null) {
      data['problem'] = this.problem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Problem {
  int id;
  int userId;
  String title;
  String message;
  int status;
  String createdAt;
  String updatedAt;
  String replyBy;
  String name;
  User user;

  Problem(
      {this.id,
      this.userId,
      this.title,
      this.message,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.replyBy,
      this.name,
      this.user});

  Problem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'] != null ? json['message'] : "";
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    replyBy = json['reply_by'];
    name = json['name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reply_by'] = this.replyBy;
    data['name'] = this.name;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}*/
