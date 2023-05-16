import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  //Load
  static late SharedPreferences _preferences;

  //Storage Login
  static const _keyIsDarkMode = true;
  static const _keyIsFirstLogin = 'yes';

  //Load Datas
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  //Set Datas
  static Future setIsDarkMode(bool isDarkMode) async => await _preferences.setBool(_keyIsDarkMode.toString(), isDarkMode);
  static Future setIsFirstLogin(String isFirstLogin) async => await _preferences.setString(_keyIsFirstLogin, isFirstLogin);

  //Get Datas Login
  static bool? getIsDarkMode() => _preferences.getBool(_keyIsDarkMode.toString());
  static String? getIsFirstLogin() => _preferences.getString(_keyIsFirstLogin);
}
