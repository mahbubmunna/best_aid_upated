
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider {

  static setString(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value);
  }

  static getString(String key) async{
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key);
  }

  static saveUser(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    print(value);
    return prefs.setString(key, json.encode(value));
  }

  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
}