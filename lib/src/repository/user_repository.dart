
import 'package:bestaid/models/user.dart';
import 'package:bestaid/providers/user_provider.dart';

class UserRepository {

  static Future<UserResponse> getUser() {
    return UserProvider.getUser();
  }

  static Future<UserResponse> postUser(Map updatedData) {
    return UserProvider.postUserUpdatedData(updatedData);
  }
}