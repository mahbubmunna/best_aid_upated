import 'dart:io';

class RegisterInfo {

  static RegisterInfo mInfo;

  String name;
  String email;
  String password;
  String phone;
  String dob;
  String location;
  String permanentLocation;
  String weight;
  String height;
  String gender;
  String history;
  String photo;

  RegisterInfo();

  static RegisterInfo getInfo() {
    if (mInfo == null) {
      mInfo = RegisterInfo();
    }
    return mInfo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['dob'] = dob;
    data['location'] = location;
    data['permanent_location'] = permanentLocation;
    data['weight'] = weight;
    data['height'] = height;
    data['gender'] = gender;
    data['history'] = history;
    return data;
  }

  RegisterInfo.basic(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
  }
}
