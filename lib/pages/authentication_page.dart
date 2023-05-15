import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  //Remember variable
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    //Body of the Page
    return Scaffold(
      backgroundColor: const Color.fromARGB(213, 3, 153, 223),
      body: Center(
        child: Container(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.45,
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
                  width: screenSize.width * 0.25,
                  height: screenSize.height * 0.05,
                  child: FittedBox(
                    child: Row(
                      children: [
                        //Check Box
                        Checkbox(
                          value: rememberMe,
                          onChanged: (checked) => setState(() {
                            rememberMe = !rememberMe;
                          }),
                        ),
                        //Remember Text
                        const Text(
                          'Remember',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                          onPressed: () {},
                          child: const FittedBox(child: Text('Login')),
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
      ),
    );
  }
}
