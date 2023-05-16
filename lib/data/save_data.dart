import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  //Load
  static late SharedPreferences _preferences;

  //Storage Login
  static const _keyIsFirstOpen = true;

  //Load Datas
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  //Set Datas
  static Future setIsFirstOpen(bool isFirstOpen) async => await _preferences.setBool(_keyIsFirstOpen.toString(), isFirstOpen);

  //Get Datas Login
  static bool? getIsFirstOpen() => _preferences.getBool(_keyIsFirstOpen.toString());
}
