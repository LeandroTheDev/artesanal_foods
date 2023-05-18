class DummyAccounts {
  static const users = {
    0: {
      'name': 'test',
      'password': '123',
      'email': 'test@test.com',
    }
  };

  //Provides a dummy login request that returns a message
  static String httpDummyData(data, {isLogin = false}) {
    if (isLogin) {
      if (data['email'] == users[data['id']]?['email']) {
        if (data['password'] == users[data['id']]?['password']) {
          return 'Success';
        }
      }
      return 'Wrong Password';
    }
    return 'null';
  }
}

class DummyProducts {
  static const products = {
    'brigadeiro_big_granulated': {
      'id': 0,
      'image': 'assets/images/products/brigadeiro_big_granulated.png',
      'name': 'Brigadeiro Big Granulated',
      'category': 'Chocolate',
      'price': 1.12,
      'isPromoted': 0.0,
      'units': 1,
      'combo1': [20.0, 20.0],
      'combo2': [100.0, 90.0],
    },
    'brigadeiro': {
      'id': 1,
      'image': 'assets/images/products/brigadeiro.jpg',
      'name': 'Brigadeiro',
      'category': 'Chocolate',
      'price': 1.0,
      'isPromoted': 0.0,
      'units': 1,
      'combo1': [20.0, 18.0],
      'combo2': [100.0, 80.0],
    },
    'chocolate_cake': {
      'id': 2,
      'image': 'assets/images/products/chocolate_cake.jpg',
      'name': 'Chocolate Cake',
      'category': 'Chocolate',
      'price': 2.15,
      'isPromoted': 1.99,
      'units': 1,
      'combo1': [20.0, 38.0],
      'combo2': [100.0, 170.0],
    },
    'cocoa_pave_with_red_fruits': {
      'id': 3,
      'image': 'assets/images/products/cocoa_pave_with_red_fruits.png',
      'name': 'Cocoa Pave With Red Fruits',
      'category': 'Fruits',
      'price': 19.99,
      'isPromoted': 0.0,
      'units': 1,
      'combo1': [5, 80.0],
      'combo2': [10, 150.0],
    },
    'lemon_cake_with_chocolate': {
      'id': 4,
      'image': 'assets/images/products/lemon_cake_with_chocolate.jpg',
      'name': 'Lemon Cake With Chocolate',
      'category': 'Fruits',
      'price': 1.80,
      'isPromoted': 1.70,
      'units': 1,
      'combo1': [20.0, 35.0],
    },
    'macarons': {
      'id': 5,
      'image': 'assets/images/products/macarons.jpg',
      'name': 'Macarons',
      'category': 'Sugary',
      'price': 0.50,
      'isPromoted': 0.0,
      'units': 1,
      'combo1': [20.0, 8.50],
      'combo2': [100.0, 40.0],
    },
    'pbs_with_chocolate': {
      'id': 6,
      'image': 'assets/images/products/pbs_with_chocolate.jpg',
      'name': 'Pineapple Banana Strawberry With Chocolate',
      'category': 'Fruits',
      'price': 0.75,
      'isPromoted': 0.0,
      'units': 1,
      'combo1': [35.0, 20.0],
      'combo2': [100.0, 50.0],
    },
    'white_chocolate_with_strawberry': {
      'id': 7,
      'image': 'assets/images/products/white_chocolate_with_strawberry.jpg',
      'name': 'White Chocolate With Strawberry',
      'category': 'Fruits',
      'price': 1.00,
      'isPromoted': 0.90,
      'units': 1,
      'combo1': [40.0, 30.0],
      'combo2': [100.0, 70.0],
    },
    'caramel_candy': {
      'id': 8,
      'image': 'assets/images/products/caramel_candy.png',
      'name': 'Caramel Candy',
      'category': 'Sugary',
      'price': 1.00,
      'isPromoted': 0.90,
      'units': 1,
      'combo1': [40.0, 30.0],
      'combo2': [100.0, 70.0],
    },
    'coconut_candy': {
      'id': 9,
      'image': 'assets/images/products/coconut_candy.png',
      'name': 'Coconut Candy',
      'category': 'Sugary',
      'price': 1.00,
      'isPromoted': 0.90,
      'units': 1,
      'combo1': [40.0, 30.0],
      'combo2': [100.0, 70.0],
    },
  };
}
