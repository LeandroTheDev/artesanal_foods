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
