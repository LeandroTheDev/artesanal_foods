import 'dart:ui';

import 'package:artesanal_foods/components/product_widget.dart';
import 'package:artesanal_foods/data/dummy_data.dart';
import 'package:artesanal_foods/data/save_data.dart';
import 'package:artesanal_foods/store/global_functions.dart';
import 'package:artesanal_foods/store/global.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BestSellers extends StatefulWidget {
  const BestSellers({super.key});

  @override
  State<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers>
    with TickerProviderStateMixin {
  TextEditingController search = TextEditingController();
  String selectedCategory = 'Sugary';

  //Bottom Bar Navigation
  int navigationIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  late ScrollController scrollController;

  //Focus Keys
  final sugaryKey = GlobalKey();
  final chocolateKey = GlobalKey();
  final fruitsKey = GlobalKey();

  //Animation Controllers
  late AnimationController _sugaryController;
  late Animation<Size> _sugaryAnimation;

  late AnimationController _chocolateController;
  late Animation<Size> _chocolateAnimation;

  late AnimationController _fruitsController;
  late Animation<Size> _fruitsAnimation;

  //Focus on selected Category
  Future focusCategory(category) async {
    sugary() async {
      final context = sugaryKey.currentContext!;
      await Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300));
    }

    chocolate() async {
      final context = chocolateKey.currentContext!;
      await Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300));
    }

    fruits() async {
      final context = fruitsKey.currentContext!;
      await Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300));
    }

    switch (selectedCategory) {
      case 'Sugary':
        sugary();
      case 'Chocolate':
        chocolate();
      case 'Fruits':
        fruits();
    }
  }

  //Returns Selected Category all Products
  returnCategoryProduct(category) {
    List products = [];
    DummyProducts.products.forEach((k, v) {
      if (v['category'] == category) {
        products.add(v);
      }
    });
    return products;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    //Sugary Animations
    _sugaryController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _sugaryAnimation = Tween(
      begin: const Size(45, 20),
      end: const Size(35, 0),
    ).animate(CurvedAnimation(parent: _sugaryController, curve: Curves.easeIn));

    //Chocolate Animations
    _chocolateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _chocolateAnimation = Tween(
      begin: const Size(35, 0),
      end: const Size(45, 20),
    ).animate(
        CurvedAnimation(parent: _chocolateController, curve: Curves.easeIn));

    //Fruits Animations
    _fruitsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _fruitsAnimation = Tween(
      begin: const Size(35, 0),
      end: const Size(45, 20),
    ).animate(CurvedAnimation(parent: _fruitsController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final data = Provider.of<SystemData>(context, listen: false);
    final products = returnCategoryProduct(selectedCategory);

    //Animation Helper
    reverseOtherCategories() {
      switch (selectedCategory) {
        case 'Sugary':
          _sugaryController.forward();
        case 'Chocolate':
          _chocolateController.reverse();
        case 'Fruits':
          _fruitsController.reverse();
      }
    }

    //Widgets
    final drawer = Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Drawer(
          width: screenSize.width,
          child: Column(
            children: [
              //Spacer
              SizedBox(height: screenSize.height * 0.05),
              //Close Button
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: GlobalFunctions.returnThemeColor(
                        data.isDarkMode, context,
                        isPrimary: false),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Spacer(),
              //Logout Button
              ElevatedButton(
                onPressed: () {
                  SaveData.setRemember('false');
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authentication_page', (route) => false);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ));

    final pages = [
      //Best Sellers
      Stack(
        children: [
          //Background Image
          Observer(
            builder: (_) => Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color:
                    GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                image: DecorationImage(
                  image: ExactAssetImage(data.isDarkMode
                      ? 'assets/images/background_black.png'
                      : 'assets/images/background_white.png'),
                  fit: GlobalFunctions.isMonitor(screenSize)
                      ? BoxFit.fill
                      : BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.02),
                //AppBar
                Row(
                  children: [
                    //Profile Button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: GlobalFunctions.returnThemeColor(
                                      data.isDarkMode, context,
                                      isPrimary: false)),
                              child: Icon(Icons.person,
                                  color: GlobalFunctions.returnThemeColor(
                                      data.isDarkMode, context)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Welcome Text
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 30,
                        color: GlobalFunctions.returnThemeColor(
                            data.isDarkMode, context,
                            isPrimary: false),
                      ),
                    )
                  ],
                ),
                //Spacer
                SizedBox(height: screenSize.height * 0.02),
                //Welcome text
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: screenSize.height * 0.3,
                  child: FittedBox(
                    child: Text(
                      'The Best\nArtisians Foods\nAre Here',
                      style: TextStyle(
                          fontSize: 100,
                          color: GlobalFunctions.returnThemeColor(
                              data.isDarkMode, context,
                              isPrimary: false),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //Search
                Row(
                  children: [
                    //Spacer
                    SizedBox(width: screenSize.width * 0.05),
                    //Input
                    Container(
                      alignment: Alignment.centerLeft,
                      width: screenSize.width * 0.5,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: GlobalFunctions.returnThemeColor(
                            data.isDarkMode, context,
                            isPrimary: false),
                      ),
                      //Search
                      child: Row(
                        children: [
                          //Spacer
                          SizedBox(width: screenSize.width * 0.02),
                          //Search icon
                          SizedBox(
                              width: screenSize.width * 0.05,
                              child: const Icon(Icons.search)),
                          //Spacer
                          SizedBox(width: screenSize.width * 0.04),
                          //Input
                          Container(
                            width: screenSize.width * 0.38,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            height: 50,
                            child: TextFormField(
                              controller: search,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              style: const TextStyle(fontSize: 25.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Spacer
                    SizedBox(width: screenSize.width * 0.25),
                    //Search Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: screenSize.width * 0.15,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: GlobalFunctions.returnThemeColor(
                              data.isDarkMode, context,
                              isPrimary: false),
                        ),
                        //Search
                        child: const Icon(
                          Icons.check,
                          size: 40,
                        ),
                      ),
                    ),
                    //Spacer
                    SizedBox(width: screenSize.width * 0.05),
                  ],
                ),
                //Spacer
                SizedBox(height: screenSize.height * 0.05),
                //Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //Spacer
                      SizedBox(width: screenSize.height * 0.02),
                      //Sugary
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            reverseOtherCategories();
                            _sugaryController.reverse();
                            selectedCategory = 'Sugary';
                            focusCategory(selectedCategory);
                          });
                        },
                        child: Container(
                          key: sugaryKey,
                          alignment: Alignment.center,
                          width: 150,
                          height: 105,
                          child: AnimatedBuilder(
                            animation: _sugaryAnimation,
                            builder: (BuildContext context, Widget? child) =>
                                Padding(
                              padding: EdgeInsets.only(
                                  bottom: _sugaryAnimation.value.height),
                              child: Text(
                                'Sugary',
                                style: TextStyle(
                                    fontSize: _sugaryAnimation.value.width,
                                    color: selectedCategory == 'Sugary'
                                        ? Colors.white
                                        : GlobalFunctions.returnThemeColor(
                                            data.isDarkMode, context,
                                            isPrimary: false)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Chocolate
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            reverseOtherCategories();
                            _chocolateController.forward();
                            selectedCategory = 'Chocolate';
                            focusCategory(selectedCategory);
                          });
                        },
                        child: Container(
                          key: chocolateKey,
                          alignment: Alignment.center,
                          width: 210,
                          height: 105,
                          child: AnimatedBuilder(
                            animation: _chocolateAnimation,
                            builder: (BuildContext context, Widget? child) =>
                                Padding(
                              padding: EdgeInsets.only(
                                  bottom: _chocolateAnimation.value.height),
                              child: Text(
                                'Chocolate',
                                style: TextStyle(
                                    fontSize: _chocolateAnimation.value.width,
                                    color: selectedCategory == 'Chocolate'
                                        ? Colors.white
                                        : GlobalFunctions.returnThemeColor(
                                            data.isDarkMode, context,
                                            isPrimary: false)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Fruits
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            reverseOtherCategories();
                            _fruitsController.forward();
                            selectedCategory = 'Fruits';
                            focusCategory(selectedCategory);
                          });
                        },
                        child: Container(
                          key: fruitsKey,
                          alignment: Alignment.center,
                          width: 120,
                          height: 105,
                          child: AnimatedBuilder(
                            animation: _fruitsAnimation,
                            builder: (BuildContext context, Widget? child) =>
                                Padding(
                              padding: EdgeInsets.only(
                                  bottom: _fruitsAnimation.value.height),
                              child: Text(
                                'Fruits',
                                style: TextStyle(
                                    fontSize: _fruitsAnimation.value.width,
                                    color: selectedCategory == 'Fruits'
                                        ? Colors.white
                                        : GlobalFunctions.returnThemeColor(
                                            data.isDarkMode, context,
                                            isPrimary: false)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Products
                SizedBox(
                  width: screenSize.width,
                  height: 350,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductWidget(
                              products[index]['id'],
                              products[index]['name'],
                              products[index]['image'],
                              products[index]['price'],
                              products[index]['isPromoted'],
                            ),
                          )),
                ),
                //Spacer
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
      //Cart Items
      Stack(
        children: [
          //Background Image
          Observer(
            builder: (_) => Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color:
                    GlobalFunctions.returnThemeColor(data.isDarkMode, context),
                image: DecorationImage(
                  image: ExactAssetImage(data.isDarkMode
                      ? 'assets/images/background_black.png'
                      : 'assets/images/background_white.png'),
                  fit: GlobalFunctions.isMonitor(screenSize)
                      ? BoxFit.fill
                      : BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        drawer: drawer,
        bottomNavigationBar: ScrollHideWidget(
          scrollController: scrollController,
          child: Theme(
            //Icon Color
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: GlobalFunctions.returnThemeColor(
                    data.isDarkMode, context,
                    isPrimary: true),
              ),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              index: navigationIndex,
              onTap: (navigationIndex) =>
                  setState(() => this.navigationIndex = navigationIndex),
              //Button Color
              buttonBackgroundColor: Colors.pink,
              //Barrer Color
              color: GlobalFunctions.returnThemeColor(data.isDarkMode, context,
                  isPrimary: false),
              //Background Color
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeOutCubic,
              animationDuration: const Duration(milliseconds: 1000),
              height: 55,
              items: const [Icon(Icons.home), Icon(Icons.shopping_cart)],
            ),
          ),
        ),
        body: pages[navigationIndex]);
  }
}

class ScrollHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;

  const ScrollHideWidget(
      {required this.child,
      required this.scrollController,
      this.duration = const Duration(milliseconds: 200),
      super.key});

  @override
  State<ScrollHideWidget> createState() => _ScrollHideWidgetState();
}

class _ScrollHideWidgetState extends State<ScrollHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(listen);
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.removeListener(listen);
  }

  listen() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: Wrap(children: [
        Padding(padding: const EdgeInsets.only(top: 10), child: widget.child)
      ]),
    );
  }
}
