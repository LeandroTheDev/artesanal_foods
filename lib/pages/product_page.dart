import 'dart:ui';

import 'package:artesanal_foods/data/dummy_data.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:artesanal_foods/store/global_functions.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double price;
  final double isPromoted;
  const ProductPage(this.id, this.name, this.image, this.price, this.isPromoted, {super.key});

  //Returns Selected Category all Products
  returnProducts() {
    List products = [];
    DummyProducts.products.forEach((k, v) => products.add(v));
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SystemData>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    final products = returnProducts();
    List comboQuantityCalculation() {
      int i = 1;
      List combo = [];
      //Verify if doesnt have combo
      if (products[id]['combo$i'] == null) {
        return [];
      }
      //Calculation
      while (true) {
        if (products[id]['combo$i'] != null) {
          i++;
          combo.add(0);
        } else {
          break;
        }
      }
      return combo;
    }

    final comboQuantity = comboQuantityCalculation();
    int unitQuantity = 0;

    //Returns combo quantity
    returnComboQuantity([isCalculation = false]) {
      int i = 1;
      //Verify if doesnt have combo
      if (products[id]['combo$i'] == null) {
        return 0;
      }
      //Calculation
      while (true) {
        if (products[id]['combo$i'] != null) {
          i++;
        } else {
          break;
        }
      }
      return i - 1;
    }

    //Total combo price
    returnTotalComboPrice() {
      double price = 0.0;
      for (int i = 0; i < comboQuantity.length; i++) {
        price = price + (products[id]['combo${i + 1}'][1] * comboQuantity[i]);
      }
      return price;
    }

    //Show Add Cart
    showAddCartModal() {
      addCart() {
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //Desc
                    Text(
                      'The following items will be added to the cart:',
                      style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false)),
                    ),
                    //Spacer
                    const SizedBox(height: 10),
                    //Product Name
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        products[id]['name'],
                        style: TextStyle(
                            fontSize: 20,
                            color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Quantitys
                    ListView.builder(
                        itemCount: comboQuantity.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return unitQuantity == 0
                                ? const SizedBox()
                                : Text(
                                    'Single Units: $unitQuantity',
                                    style:
                                        TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false)),
                                  );
                          }
                          return comboQuantity[index - 1] == 0
                              ? const SizedBox()
                              : Text(
                                  'Combo ${products[id]['combo$index'][0].toStringAsFixed(0)} units: ${comboQuantity[index - 1]}',
                                  style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false)),
                                );
                        }),
                    //Spacer
                    const SizedBox(height: 15),
                    //Total
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total: \$${(products[id]['price'] * unitQuantity) + returnTotalComboPrice()}',
                        style: TextStyle(fontSize: 20, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false)),
                      ),
                    ),
                  ],
                ),
              ),
              //Button
              Row(
                children: [
                  //Ok
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 236, 69, 125)),
                        onPressed: () {
                          Navigator.pop(context);
                          data.addCartItem({
                            'name': products[id]['name'],
                            'unit': unitQuantity,
                            'combo': comboQuantity,
                            'total': (products[id]['price'] * unitQuantity) + returnTotalComboPrice(),
                          });
                        },
                        child: const FittedBox(child: Text('Ok', style: TextStyle(color: Color.fromARGB(255, 44, 42, 42), fontSize: 100))),
                      ),
                    ),
                  ),
                  const Spacer(),
                  //Cancel
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
                        child: const FittedBox(child: Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 44, 42, 42), fontSize: 100))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).show();
      }

      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => Container(
                height: screenSize.height * 0.4,
                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isTransparent: true),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Unit
                      Row(
                        children: [
                          //Spacer
                          SizedBox(
                            width: screenSize.width * 0.2 - 16,
                          ),
                          //Combo Desc
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.25 - 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        '1 unit',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                        ),
                                      ),
                                      Text(
                                        products[id]['isPromoted'] != 0 ? '\$${products[id]['isPromoted']}' : '\$${products[id]['price']}',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Spacer
                          SizedBox(
                            width: screenSize.width * 0.18 - 16,
                          ),
                          //Quantitys
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.4 - 16,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                              ),
                              child: Row(
                                children: [
                                  //Remove
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (unitQuantity != 0) {
                                          unitQuantity--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      width: screenSize.width * 0.13 - 16,
                                      height: 75,
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  //Divider
                                  VerticalDivider(
                                    thickness: 2,
                                    width: 0,
                                    color: GlobalFunctions.returnThemeColor(
                                      data.isDarkMode,
                                      context,
                                    ),
                                  ),
                                  //Quantity
                                  Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width * 0.21 - 16,
                                    height: 75,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          unitQuantity.toString(),
                                          style: TextStyle(fontSize: 100, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Divider
                                  VerticalDivider(
                                    thickness: 2,
                                    width: 0,
                                    color: GlobalFunctions.returnThemeColor(
                                      data.isDarkMode,
                                      context,
                                    ),
                                  ),
                                  //Add
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        unitQuantity++;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      width: screenSize.width * 0.13 - 16,
                                      height: 75,
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Combos
                      Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: returnComboQuantity(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Row(
                              children: [
                                //Combo Desc
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: screenSize.width * 0.55 - 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              'Combo ${products[id]['combo${index + 1}'][0].toStringAsFixed(0)} units',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '\$${products[id]['combo${index + 1}'][1].toString()}',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                //Quantitys
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: screenSize.width * 0.4 - 16,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                                    ),
                                    child: Row(
                                      children: [
                                        //Remove
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (comboQuantity[index] != 0) {
                                                comboQuantity[index]--;
                                              }
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.transparent,
                                            width: screenSize.width * 0.13 - 16,
                                            height: 75,
                                            child: const Icon(Icons.remove),
                                          ),
                                        ),
                                        //Divider
                                        VerticalDivider(
                                          thickness: 2,
                                          width: 0,
                                          color: GlobalFunctions.returnThemeColor(
                                            data.isDarkMode,
                                            context,
                                          ),
                                        ),
                                        //Quantity
                                        Container(
                                          alignment: Alignment.center,
                                          width: screenSize.width * 0.21 - 16,
                                          height: 75,
                                          child: FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                comboQuantity[index].toString(),
                                                style: TextStyle(fontSize: 100, color: GlobalFunctions.returnThemeColor(data.isDarkMode, context)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Divider
                                        VerticalDivider(
                                          thickness: 2,
                                          width: 0,
                                          color: GlobalFunctions.returnThemeColor(
                                            data.isDarkMode,
                                            context,
                                          ),
                                        ),
                                        //Add
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              comboQuantity[index]++;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.transparent,
                                            width: screenSize.width * 0.13 - 16,
                                            height: 75,
                                            child: const Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      //Add Cart Button
                      SizedBox(
                        width: screenSize.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                          ),
                          onPressed: () => addCart(),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: GlobalFunctions.returnThemeColor(
                                      data.isDarkMode,
                                      context,
                                    ),
                                    fontSize: 100),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: Stack(
        children: [
          //Background Image
          Observer(
            builder: (_) => Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                image: DecorationImage(
                  image: ExactAssetImage(data.isDarkMode ? 'assets/images/background_product.png' : 'assets/images/background_product.png'),
                  fit: GlobalFunctions.isMonitor(screenSize) ? BoxFit.fill : BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                //Spacer
                SizedBox(height: screenSize.height * 0.1),
                //Image
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: id,
                    child: Container(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(image: ExactAssetImage(image), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                //Spacer
                const SizedBox(height: 25),
                //Product Name
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenSize.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                        ),
                      ),
                    ),
                  ),
                ),
                //Spacer
                const SizedBox(height: 10),
                //Product Prices
                Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: returnComboQuantity(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Row(
                        children: [
                          //Combo Desc
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.55 - 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Combo ${products[id]['combo${index + 1}'][0].toStringAsFixed(0)} units',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Spacer
                          SizedBox(
                            width: screenSize.width * 0.05,
                          ),
                          //Combo Price
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width * 0.4 - 16,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: GlobalFunctions.returnThemeColor(data.isDarkMode, context, isPrimary: false),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: FittedBox(
                                  child: Text(
                                    '\$${products[id]['combo${index + 1}'][1].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                //Spacer
                const SizedBox(height: 35),
                //Add to cart button
                SizedBox(
                  width: screenSize.width * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 236, 69, 125),
                    ),
                    onPressed: () => showAddCartModal(),
                    child: FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 100,
                          color: GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                        ),
                      ),
                    )),
                  ),
                ),
                //Spacer
                const SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }
}
