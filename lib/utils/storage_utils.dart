import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static const String keyLoginData = "loginData";
  static const String keyToken = "token";

  static Future<dynamic> setData(String key, dynamic value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value is String) {
      return pref.setString(key, value);
    } else if (value is int) {
      return pref.setInt(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else {
      return pref.setString(key, value);
    }
  }

  static Future<dynamic> getData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static void clearData() {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
  }

  static Future<dynamic> clearspecfickey(String key, dynamic value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  static void clearLoginData() {
    SharedPreferences.getInstance().then((value) {
      value.remove(keyLoginData);
      value.remove(keyToken);
    });
  }
}
