import 'package:bestaid/src/models/doctors.dart';

enum UserState { available, away, busy }

class UserResponse {
  User user;
  String error;
  String accessToken;
  String message;

  UserResponse.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? new User.fromJson(json['user']) : null,
        error = "",
        accessToken = json['access_token'],
        message = json['message'];

  UserResponse.withError(String errorValue)
      : user = User.init(),
        error = errorValue;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['access_token'] = this.accessToken;
    data['message'] = this.message;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String role;
  String deviceToken;
  String phone;
  String dob;
  String location;
  String weight;
  String height;
  String gender;
  String history;
  String photo;
  String permanentLocation;
  Doctors doctor;

  User.init();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt =
        json['email_verified_at'] != null ? json['email_verified_at'] : "";
    createdAt = json['created_at'] != null ? json['created_at'] : "";
    updatedAt = json['updated_at'] != null ? json['updated_at'] : "";
    role = json['role'] != null ? json['role'] : "";
    deviceToken = json['device_token'] != null ? json['device_token'] : "";
    phone = json['phone'] != null ? json['phone'] : "";
    dob = json['dob'] != null ? json['dob'] : "";
    location = json['location'] != null ? json['location'] : "";
    weight = json['weight'] != null ? json['weight'] : "";
    height = json['height'] != null ? json['height'] : "";
    gender = json['gender'] != null ? json['gender'] : "";
    history = json['history'] != null ? json['history'] : "";
    photo = json['photo'] != null ? json['photo'] : "";
    permanentLocation =
        json['permanent_location'] != null ? json['permanent_location'] : "";
    doctor =
        json['doctor'] != null ? new Doctors.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['device_token'] = this.deviceToken;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['gender'] = this.gender;
    data['history'] = this.history;
    data['photo'] = this.photo;
    data['permanent_location'] = this.permanentLocation;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    return data;
  }

  @override
  String toString() => this.location + " " + this.name + " " + this.email;
}
