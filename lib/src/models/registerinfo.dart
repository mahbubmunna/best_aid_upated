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

  Map<String, String> toJsonString() {
    final Map<String, String> data = new Map<String, String>();
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone==null?"":phone;
    data['dob'] = dob==null?"":dob;
    data['location'] = location==null?"":location;
    data['permanent_location'] = permanentLocation==null?"":permanentLocation;
    data['weight'] = weight==null?"":weight;
    data['height'] = height==null?"":height;
    data['gender'] = gender==null?"":gender;
    data['history'] = history==null?"":history;
    return data;
  }

  RegisterInfo.basic(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
  }
}
