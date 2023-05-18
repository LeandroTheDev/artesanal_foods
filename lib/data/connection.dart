import 'package:artesanal_foods/store/global_functions.dart';
import 'package:artesanal_foods/data/dummy_data.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';

class Connection {
  static Future<String> login(email, password) async {
    final result = DummyAccounts.httpDummyData(isLogin: true, {
      'id': 0,
      'email': email,
      'password': password,
    });
    return result;
  }

  static Future<void> resultResponses(context, String result) async {
    const isDarkMode = true;
    invalidLogin() async {
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        dialogBackgroundColor: GlobalFunctions.returnThemeColor(isDarkMode, context),
        borderSide: BorderSide(
          color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false),
          width: 2,
        ),
        width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
        body: Column(
          children: [
            //Description
            Container(
              width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Text(
                'An internal error occurred, we will redirect you to the authentication page.',
                style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false)),
              ),
            ),
            //Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const FittedBox(child: Text('Ok', style: TextStyle(color: Color.fromARGB(255, 44, 42, 42), fontSize: 100))),
                ),
              ),
            ),
          ],
        ),
      ).show().then((value) async {
        Navigator.pushNamedAndRemoveUntil(context, '/authentication_page', (route) => false);
      });
    }

    wrongPassword() async {
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        dialogBackgroundColor: GlobalFunctions.returnThemeColor(isDarkMode, context),
        borderSide: BorderSide(
          color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false),
          width: 2,
        ),
        width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
        body: Column(
          children: [
            //Description
            Container(
              width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Our candy machine says your credentials are wrong.',
                style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false)),
              ),
            ),
            //Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const FittedBox(child: Text('Ok', style: TextStyle(color: Color.fromARGB(255, 44, 42, 42), fontSize: 100))),
                ),
              ),
            ),
          ],
        ),
      ).show();
    }

    switch (result) {
      case 'Invalid Login':
        return invalidLogin();
      case 'Wrong Password':
        return wrongPassword();
    }
  }
}
