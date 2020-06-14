import 'package:bestaid/src/models/user.dart';

class DiscussionResponse {
  Problem problem;

  DiscussionResponse({this.problem});

  DiscussionResponse.fromJson(Map<String, dynamic> json) {
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

class Problem {
  int id;
  int userId;
  String title;
  String message;
  int status;
  String createdAt;
  String updatedAt;
  int replyBy;
  String name;
  List<Discussion> discussion;
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
        this.discussion,
        this.user});

  Problem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    replyBy = json['reply_by'];
    name = json['name'];
    if (json['discussion'] != null) {
      discussion = new List<Discussion>();
      json['discussion'].forEach((v) {
        discussion.add(new Discussion.fromJson(v));
      });
    }
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
    if (this.discussion != null) {
      data['discussion'] = this.discussion.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Discussion {
  int id;
  int problemId;
  String message;
  String type;
  String createdAt;
  String updatedAt;
  int replyBy;

  Discussion(
      {this.id,
        this.problemId,
        this.message,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.replyBy});

  Discussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    problemId = json['problem_id'];
    message = json['message'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    replyBy = json['reply_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['problem_id'] = this.problemId;
    data['message'] = this.message;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reply_by'] = this.replyBy;
    return data;
  }
}