import 'dart:convert';

import 'package:bestaid/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider {
  static setString(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value);
  }

  static getString(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key);
  }

  static Future<bool> saveUser(String key, User value) async {
    final prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(value.toJson());
    print("User is saved $user");
    return prefs.setString(key, user);
  }

  static Future<User> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      User user = User.fromJson(jsonDecode(prefs.getString('user')));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }

  static reads(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
