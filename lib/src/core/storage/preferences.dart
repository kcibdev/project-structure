import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static SharedPreferences? _prefs;

  static SharedPreferences? get prefs => _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String data) async =>
      _prefs!.setString(key, data);

  static String getString(String key) => _prefs!.getString(key) ?? '';

  static Future<bool> setBool(String key, bool data) async =>
      _prefs!.setBool(key, data);

  static bool getBool(String key) => _prefs!.getBool(key) ?? false;

  static List<String> getList(String key) => _prefs!.getStringList(key) ?? [];

  static Future<bool> setList(String key, List<String> list) async =>
      _prefs!.setStringList(key, list);

  static Future<bool> clear() async => _prefs!.clear();

  static Future<bool> removePrefs(String key) async => _prefs!.remove(key);

  static int get theme => _prefs!.getInt('theme') ?? 0;

  static set theme(int value) {
    _prefs!.setInt('theme', value);
  }

  static String get customerId => _prefs!.getString('customerId') ?? '';

  static set customerId(String value) {
    _prefs!.setString('customerId', value);
  }

  static String get token => _prefs!.getString('user_token') ?? '';

  static set token(String value) {
    _prefs!.setString('user_token', value);
  }

  static String get email => _prefs!.getString('user_email') ?? '';

  static set email(String value) {
    _prefs!.setString('user_email', value);
  }
}
