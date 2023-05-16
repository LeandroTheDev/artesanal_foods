import 'package:artesanal_foods/components/global_functions.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:flutter/material.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final global = SystemData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Stack(
        children: [
          Container(
              color: GlobalFunctions.returnThemeColor(global.isDarkMode, context),
              width: screenSize.width,
              height: screenSize.height,
              child: Image.asset(
                'assets/images/background_menu.png',
                fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
              )),
          const Column(),
        ],
      ),
    );
  }
}
