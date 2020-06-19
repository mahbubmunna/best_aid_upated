import 'dart:io';

import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/user_provider.dart';

class UserRepository {
  static Future<UserResponse> getUser() {
    return UserProvider.getUser();
  }

  static Future<UserResponse> updateUserData(Map updatedUserData) {
    return UserProvider.updateUserData(updatedUserData);
  }

  static Future<UserResponse> postUser(Map loginInfo) {
    return UserProvider.postLoginData(loginInfo);
  }

  static Future<UserResponse> registerUser(Map<String,String> registerInfo) {
    return UserProvider.registerUser(registerInfo);
  }

  static Future<UserResponse>upload(String imageFile, var values){
   return  UserProvider.upload(imageFile, values);
  }
  static Future<String>updateUserDataWithPhoto(String imageFile, var values){
    return  UserProvider.updateUserDataWithPhoto(imageFile, values);
  }
}
