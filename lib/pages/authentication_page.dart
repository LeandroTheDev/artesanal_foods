import 'package:artesanal_foods/components/global_functions.dart';
import 'package:artesanal_foods/data/save_data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final bool isFirstOpen;
  //Pickup system theme
  bool isDarkMode = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    //Delete after debugging
    SaveData.setIsFirstOpen(true);
    //First Open Dialog
    isFirstOpen = SaveData.getIsFirstOpen() ?? true;
    if (isFirstOpen) {
      Future.delayed(const Duration(milliseconds: 500)).then((value) => AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            dialogBackgroundColor: GlobalFunctions.returnThemeColor(isDarkMode, context),
            borderSide: BorderSide(
              color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false),
              width: 2,
            ),
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            onDismissCallback: (_) {},
            width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            body: Column(
              children: [
                //Description
                Container(
                  width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Hey,\nour chocolate bars, told us it\'s your first time here.\nwhat\'s your favorite theme?',
                    style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(isDarkMode, context, isPrimary: false)),
                  ),
                ),
                //Buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      children: [
                        //Black Theme
                        SizedBox(
                          width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 44, 42, 42)),
                            onPressed: () {
                              SaveData.setIsFirstOpen(false);
                              Navigator.pop(context);
                            },
                            child: const FittedBox(child: Text('Black Chocolate', style: TextStyle(fontSize: 100))),
                          ),
                        ),
                        //Spacer
                        SizedBox(
                          width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.1,
                        ),
                        //White Theme
                        SizedBox(
                          width: GlobalFunctions.isMonitor(MediaQuery.of(context).size) ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                            onPressed: () {
                              SaveData.setIsFirstOpen(false);
                              Navigator.pop(context);
                            },
                            child: const FittedBox(child: Text('White Chocolate', style: TextStyle(color: Color.fromARGB(255, 44, 42, 42), fontSize: 100))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).show());
    }
  }

  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    loginButton() {}

    final mobile = Center(
      child: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.4,
        //Decoration of the box (Circular and Color)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        //Texts and TextForms in the white box
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Welcome Text
              Center(
                child: SizedBox(
                  height: screenSize.height * 0.05,
                  child: const FittedBox(
                    child: Text(
                      'Welcome',
                      style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.w900, fontSize: 1000),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //E-mail Input
              Container(
                padding: const EdgeInsets.all(8.0),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.08,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  initialValue: '',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              //Password Input
              Container(
                padding: const EdgeInsets.all(8.0),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.08,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  initialValue: '',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              //Remember CheckBox
              SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.05,
                child: FittedBox(
                  child: Row(
                    children: [
                      //Check Box
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color.fromARGB(255, 236, 69, 125),
                        ),
                        child: Checkbox(
                          activeColor: const Color.fromARGB(255, 236, 69, 125),
                          value: rememberMe,
                          onChanged: (checked) => setState(
                            () {
                              rememberMe = !rememberMe;
                            },
                          ),
                        ),
                      ),
                      //Remember Text
                      const Text(
                        'Remember',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //Spacer
                      SizedBox(width: screenSize.width * 0.4)
                    ],
                  ),
                ),
              ),
              //Login Button
              SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.1,
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: screenSize.width * 0.2,
                      height: screenSize.height * 0.05,
                      child: ElevatedButton(
                        onPressed: loginButton(),
                        child: const FittedBox(child: Text('Login', style: TextStyle(fontSize: 100))),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    final monitor = Center(
      child: Container(
        width: screenSize.width * 0.3,
        height: screenSize.height * 0.4,
        //Decoration of the box (Circular and Color)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        //Texts and TextForms in the white box
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Welcome Text
              Center(
                child: SizedBox(
                  height: screenSize.height * 0.05,
                  child: const FittedBox(
                    child: Text(
                      'Welcome',
                      style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.w900, fontSize: 1000),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //E-mail Input
              Container(
                padding: const EdgeInsets.all(8.0),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.08,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  initialValue: '',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              //Password Input
              Container(
                padding: const EdgeInsets.all(8.0),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.08,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  initialValue: '',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              //Remember CheckBox
              SizedBox(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.05,
                child: FittedBox(
                  child: Row(
                    children: [
                      //Check Box
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color.fromARGB(255, 236, 69, 125),
                        ),
                        child: Checkbox(
                          activeColor: const Color.fromARGB(255, 236, 69, 125),
                          value: rememberMe,
                          onChanged: (checked) => setState(
                            () {
                              rememberMe = !rememberMe;
                            },
                          ),
                        ),
                      ),
                      //Remember Text
                      const Text(
                        'Remember',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //Spacer
                      SizedBox(width: screenSize.width * 0.2)
                    ],
                  ),
                ),
              ),
              //Login Button
              SizedBox(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.1,
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: screenSize.width * 0.05,
                      height: screenSize.height * 0.05,
                      child: ElevatedButton(
                        onPressed: loginButton(),
                        child: const FittedBox(child: Text('Login', style: TextStyle(fontSize: 100))),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    //Body of the Page
    return Scaffold(
      backgroundColor: const Color.fromARGB(213, 3, 153, 223),
      body: Stack(
        children: [
          Container(
            color: GlobalFunctions.returnThemeColor(isDarkMode, context),
            width: screenSize.width,
            height: screenSize.height,
            child: isDarkMode
                ? Image.asset(
                    'assets/images/background_black.png',
                    fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
                  )
                : Image.asset(
                    'assets/images/background_white.png',
                    fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
                  ),
          ),
          GlobalFunctions.isMonitor(screenSize) ? monitor : mobile,
        ],
      ),
    );
  }
}
