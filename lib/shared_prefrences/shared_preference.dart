import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesHelper {
  static Future<void> saveString(String key, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? "";
  }
}
