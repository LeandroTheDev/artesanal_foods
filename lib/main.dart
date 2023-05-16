import 'package:artesanal_foods/data/save_data.dart';
import 'package:artesanal_foods/pages/authentication_page.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveData.init();
  runApp(const ArtesanalFoods());
}

class ArtesanalFoods extends StatelessWidget {
  const ArtesanalFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artesanal Foods',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: const Color.fromARGB(255, 44, 42, 42),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 44, 42, 42),
          secondary: Colors.blue,
        ),
      ),
      home: const AuthenticationPage(),
    );
  }
}
