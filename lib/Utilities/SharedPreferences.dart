import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Themes/AppStrings.dart';

class SharedPrefs {
  // static late final SharedPreferences _prefsInstance;
  static late SharedPreferences _prefsInstance;

  // static Future<SharedPreferences> init() async =>
  //     _prefsInstance = await SharedPreferences.getInstance();
    // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  // // ADDED 
  // static bool get isInitialized => _prefsInstance != null;

  static String getString(String key, {String defValue = ""}) =>
      _prefsInstance.getString(key) ?? defValue;
  static void setString(String key, String value) async =>
      _prefsInstance.setString(key, value);

  static bool getBool(String key, {bool defValue = false}) =>
      _prefsInstance.getBool(key) ?? defValue;
  static void setBool(String key, bool value) async =>
      _prefsInstance.setBool(key, value);

  static int getInt(String key, {int defValue = 0}) =>
      _prefsInstance.getInt(key) ?? defValue;
  static void setInt(String key, int value) async =>
      _prefsInstance.setInt(key, value);

  static double getDouble(String key, {double defValue = 0.0}) =>
      _prefsInstance.getDouble(key) ?? defValue;
  static void setDouble(String key, double value) async =>
      _prefsInstance.setDouble(key, value);

  //Getter setter for StringList Values
  static List<String> getStringList(String key) =>
      _prefsInstance.getStringList(key) ?? <String>[];
  static void setStringList(String key, List<String> value) async =>
      _prefsInstance.setStringList(key, value);

  //Getter setter for Custom Object Values
  static dynamic getCustomObject(String key) {
    return jsonDecode(_prefsInstance.getString(key) ?? "");
  }

  static void setCustomObject(String key, dynamic value) async {
    _prefsInstance.setString(key, jsonEncode(value));
    _prefsInstance.setBool(ISAUTOLOGIN, true);
  }

  //Getter setter for Settings Object Values
  static dynamic getSettingObject(String key) {
    return jsonDecode(_prefsInstance.getString(key) ?? "");
  }

  static void setSettingObject(String key, dynamic value) async {
    _prefsInstance.setString(key, jsonEncode(value));
  }

  //Showcase Model details
  static dynamic getShowcaseObject(String key) {
    return jsonDecode(_prefsInstance.getString(key) ?? "");
  }

  static void setShowcaseObject(String key, dynamic value) async {
    _prefsInstance.setString(key, jsonEncode(value));
  }

  static bool isContains(String key) => _prefsInstance.containsKey(key);

  static void clearAllData() async => _prefsInstance.clear();
  static void clearKeyData(String key) async => _prefsInstance.remove(key);
  static void clearLoginData() async {
    _prefsInstance.remove(LOGINDATA);
    _prefsInstance.setBool(ISAUTOLOGIN, false);
    // _prefsInstance.containsKey(LOGINDATA);
    // _prefsInstance.containsKey(ISAUTOLOGIN);
  }
}
