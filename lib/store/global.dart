import 'package:artesanal_foods/data/save_data.dart';
import 'package:mobx/mobx.dart';

part 'global.g.dart';

class SystemData = SystemBase with _$SystemData;

abstract class SystemBase with Store {
  @observable
  bool isDarkMode = true;
  @observable
  String email = '';
  @observable
  String password = '';
  @observable
  String username = '';

  @action
  void changeDarkMode(value) {
    SaveData.setIsDarkMode(value);
    isDarkMode = bool.parse(value);
  }

  @action
  void changeEmail(value) {
    email = value;
  }

  @action
  void changePassword(value) {
    password = value;
  }

  @action
  void changeUsername(value) {
    username = value;
  }
}
