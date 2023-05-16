import 'package:artesanal_foods/data/save_data.dart';
import 'package:artesanal_foods/pages/authentication_page.dart';
import 'package:artesanal_foods/pages/best_sellers.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        Provider<SystemData>(
          create: (_) => SystemData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Artesanal Foods',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          secondaryHeaderColor: const Color.fromARGB(255, 44, 42, 42),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 44, 42, 42),
            secondary: Colors.pink,
          ),
        ),
        home: const AuthenticationPage(),
        routes: {
          '/authentication_page': (context) => const AuthenticationPage(),
          '/best_sellers': (context) => const BestSellers(),
        },
      ),
    );
  }
}
