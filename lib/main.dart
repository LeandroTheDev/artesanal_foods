import 'package:artesanal_foods/pages/authentication_page.dart';

import 'package:flutter/material.dart';

void main() {
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
        secondaryHeaderColor: Colors.black,
      ),
      home: const AuthenticationPage(),
    );
  }
}
