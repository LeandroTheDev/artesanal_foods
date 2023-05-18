// ignore_for_file: use_build_context_synchronously

import 'package:artesanal_foods/store/global_functions.dart';
import 'package:artesanal_foods/data/connection.dart';
import 'package:artesanal_foods/data/save_data.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final bool isFirstOpen;
  bool rememberMe = false;
  bool isLoading = false;

  TextEditingController clientEmail = TextEditingController();
  TextEditingController clientPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Data Variable
    final data = Provider.of<SystemData>(context, listen: false);
    //First Open Dialog
    if (SaveData.getIsFirstLogin() == 'true') {
      //Pickup system theme
      SystemData().changeDarkMode((SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark).toString());
      Future.delayed(const Duration(milliseconds: 500)).then((value) => AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            dialogBackgroundColor: GlobalFunctions.returnThemeColor(SystemData().isDarkMode, context),
            borderSide: BorderSide(
              color: GlobalFunctions.returnThemeColor(SystemData().isDarkMode, context, isPrimary: false),
              width: 2,
            ),
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            onDismissCallback: (_) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                dialogBackgroundColor: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                borderSide: BorderSide(
                  color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
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
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'You can change the theme anytime in the options.',
                        style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false)),
                      ),
                    ),
                    //Button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 236, 69, 125)),
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
            },
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
                    style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(SystemData().isDarkMode, context, isPrimary: false)),
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
                              data.changeDarkMode('true');
                              SaveData.setIsFirstLogin('false');
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
                              data.changeDarkMode('false');
                              SaveData.setIsFirstLogin('false');
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
      return;
    }
    isLoading = true;
    //Remember Login
    if (SaveData.getRemember() == 'true') {
      data.changeEmail(SaveData.getEmail());
      data.changePassword(SaveData.getPassword());
      //Loading Widget
      Future.delayed(const Duration(milliseconds: 500)).then((value) => GlobalFunctions.loadingWidget(context));
      //Start Connection
      Future.delayed(const Duration(milliseconds: 1000)).then((value) async {
        final result = await Connection.login(SaveData.getEmail(), SaveData.getPassword());
        if (result == 'Success') {
          Navigator.pushNamedAndRemoveUntil(context, '/best_sellers', (route) => false);
          //Unblock button
          setState(() {
            isLoading = false;
          });
        } else {
          //Call error treatment
          await Connection.resultResponses(context, result);
          FocusManager.instance.primaryFocus?.unfocus();
          //Unblock button
          setState(() {
            isLoading = false;
          });
        }
      });
      return;
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SystemData>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;

    loginButton() async {
      //Make the login button blocked
      setState(() {
        isLoading = true;
      });
      //Initialize loading widget
      GlobalFunctions.loadingWidget(context);
      final result = await Connection.login(clientEmail.text, clientPassword.text);
      if (result == 'Success') {
        SaveData.setRemember('false');
        if (rememberMe) {
          SaveData.setEmail(clientEmail.text);
          SaveData.setPassword(clientPassword.text);
          SaveData.setRemember('true');
        }
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, '/best_sellers', (route) => false);
        //Unblock button
        setState(() {
          isLoading = false;
        });
      } else {
        //Call error treatment
        await Connection.resultResponses(context, result);
        FocusManager.instance.primaryFocus?.unfocus();
        //Unblock button
        setState(() {
          isLoading = false;
        });
      }
    }

    final mobile = Center(
      child: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.42,
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
                  controller: clientEmail,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
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
                  controller: clientPassword,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 236, 69, 125),
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                loginButton();
                              },
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
                  controller: clientEmail,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
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
                  controller: clientPassword,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 236, 69, 125),
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                loginButton();
                              },
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
          Observer(
            builder: (_) => Container(
              color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
              width: screenSize.width,
              height: screenSize.height,
              child: data.isDarkMode
                  ? Image.asset(
                      'assets/images/background_black.png',
                      fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
                    )
                  : Image.asset(
                      'assets/images/background_white.png',
                      fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
                    ),
            ),
          ),
          GlobalFunctions.isMonitor(screenSize) ? monitor : mobile,
        ],
      ),
    );
  }
}
