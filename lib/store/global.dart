import 'package:artesanal_foods/data/save_data.dart';
import 'package:mobx/mobx.dart';

part 'global.g.dart';

class SystemData = SystemBase with _$SystemData;

abstract class SystemBase with Store {
  @observable
  bool isDarkMode = true;

  @action
  void changeDarkMode(value) {
    SaveData.setIsDarkMode(value);
    isDarkMode = value;
  }
}
