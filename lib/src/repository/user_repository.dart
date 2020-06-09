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

  static Future<UserResponse> registerUser(Map registerInfo) {
    return UserProvider.postRegisterData(registerInfo);
  }
}
