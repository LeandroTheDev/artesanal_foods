import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  //Load
  static late SharedPreferences _preferences;

  //Storage Login
  static const _keyIsDarkMode = '1';
  static const _keyIsFirstLogin = '2';
  static const _keyRemember = '3';
  static const _keyEmail = '4';
  static const _keyPassword = '5';

  //Load Datas
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  //Set Datas
  static Future setIsDarkMode(String isDarkMode) async => await _preferences.setString(_keyIsDarkMode, isDarkMode);
  static Future setIsFirstLogin(String isFirstLogin) async => await _preferences.setString(_keyIsFirstLogin, isFirstLogin);
  static Future setRemember(String remember) async => await _preferences.setString(_keyRemember, remember);
  static Future setEmail(String email) async => await _preferences.setString(_keyEmail, email);
  static Future setPassword(String password) async => await _preferences.setString(_keyPassword, password);

  //Get Datas Login
  static String? getIsDarkMode() => _preferences.getString(_keyIsDarkMode);
  static String? getIsFirstLogin() => _preferences.getString(_keyIsFirstLogin);
  static String? getRemember() => _preferences.getString(_keyRemember);
  static String? getEmail() => _preferences.getString(_keyEmail);
  static String? getPassword() => _preferences.getString(_keyPassword);
}
