import 'dart:math' as math;

import 'package:artesanal_foods/pages/product_page.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:artesanal_foods/store/global_functions.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double price;
  final double isPromoted;
  const ProductWidget(
      this.id, this.name, this.image, this.price, this.isPromoted,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final data = SystemData();
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductPage(id, name, image, price, isPromoted))),
      child: Container(
        height: 350,
        width: 250,
        //Box Color
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 238, 113, 155),
              Color.fromARGB(255, 243, 58, 120),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            //Product
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: Hero(
                    tag: id,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: ExactAssetImage(image), fit: BoxFit.cover),
                      ),
                      height: 200,
                      width: 230,
                    ),
                  ),
                ),
                //Product Name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: SizedBox(
                    width: 230,
                    height: 80,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: GlobalFunctions.returnThemeColor(
                            data.isDarkMode, context),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
            //Price
            Positioned(
              left: 130,
              top: isPromoted != 0 ? 150 : 180,
              child: Container(
                width: 110,
                height: isPromoted != 0 ? 70 : 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 255, 158, 190),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: FittedBox(
                    child: Column(
                      children: [
                        isPromoted != 0
                            ? Stack(
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    child: Transform.rotate(
                                      angle: math.pi / 1.05,
                                      child: Container(
                                        color: const Color.fromARGB(
                                            166, 214, 0, 0),
                                        width: 90,
                                        height: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                '\$${price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        isPromoted != 0
                            ? Text(
                                '\$${isPromoted.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
