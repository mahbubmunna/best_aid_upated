import 'package:bestaid/config/strings.dart';
import 'package:intl/intl.dart' show DateFormat;

enum UserState { available, away, busy }

class UserResponse {
  User user;
  String error;

  UserResponse.fromJson(Map<String, dynamic> json)
    : user = User.fromJson(json),
  error = "";

  UserResponse.withError(String errorValue)
    : user = User.init(),
  error = errorValue;
}

class User {
  int id;
  String name;
  String email;
  String gender;
  String dob;
  String avatar;
  String address;
  String weight;
  String height;
  String phone;
  String error;
  UserState userState;

  User.init();

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'] ?? -1,
        dob = json['dob'],
        address = json['location'],
        weight = json['weight'],
        height = json['height'],
        phone = json['phone'],
        name = json["name"];
//        id = json['id'].toString(),
//        gender = 'Male',
//        address = json['address'] != null ? json['address'] : '',
//        city = json['city'] != null ? json['city'] : '',
//        country = json['country'] != null ? json['country'] : '',
//        dateOfBirth = DateTime(1993, 12, 31),
//        avatar = json['avatar_original'] == null ? 'https://picsum.photos/200' : public_path_url+json['avatar_original'];


  User.basic(this.name, this.avatar, this.userState);

  User.advanced(this.name, this.email, this.gender, this.dob, this.avatar, this.address, this.userState);

  User getCurrentUser() {
    return User.advanced('Andrew R. Whitesides', 'andrew@gmail.com', 'Male', 'DateTime(1994, 04, 12)', 'assets/img/user2.jpg',
        '4600 Isaacs Creek Road Golden, IL 62339', UserState.available);
  }

//  getDateOfBirth() {
//    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
//  }
}
