import 'package:flutter/material.dart';

class GlobalFunctions {
  //Return true if the screen is width is bigger than heigth
  static bool isMonitor(screenSize) {
    if (screenSize.width < screenSize.height) {
      return false;
    } else {
      return true;
    }
  }

  //Return theme colors
  static Color returnThemeColor(selectedTheme, context, {isPrimary = true}) {
    //True == Dark
    if (!selectedTheme) {
      if (isPrimary) {
        return const Color.fromARGB(255, 236, 69, 125);
      } else {
        return Colors.white;
      }
    } else {
      if (isPrimary) {
        return const Color.fromARGB(255, 44, 42, 42);
      } else {
        return const Color.fromARGB(255, 236, 69, 125);
      }
    }
  }
}
