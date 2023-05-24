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
  static Color returnThemeColor(selectedTheme, context,
      {isPrimary = true, isTransparent = false}) {
    //True == Dark
    if (!selectedTheme) {
      if (isPrimary) {
        if (isTransparent) {
          return const Color.fromARGB(100, 236, 69, 125);
        }
        return const Color.fromARGB(255, 236, 69, 125);
      } else {
        if (isTransparent) {
          return const Color.fromARGB(100, 255, 255, 255);
        }
        return Colors.white;
      }
    } else {
      if (isPrimary) {
        if (isTransparent) {
          return const Color.fromARGB(100, 44, 42, 42);
        }
        return const Color.fromARGB(255, 44, 42, 42);
      } else {
        if (isTransparent) {
          return const Color.fromARGB(100, 236, 69, 125);
        }
        return const Color.fromARGB(255, 236, 69, 125);
      }
    }
  }

  //Loading Widget
  static void loadingWidget(context) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Image.asset(
            'assets/images/loading animation.gif',
          ),
        );
      },
    );
  }
}
