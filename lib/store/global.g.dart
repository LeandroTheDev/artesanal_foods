// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SystemData on SystemBase, Store {
  late final _$isDarkModeAtom =
      Atom(name: 'SystemBase.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$emailAtom = Atom(name: 'SystemBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'SystemBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: 'SystemBase.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$cartAtom = Atom(name: 'SystemBase.cart', context: context);

  @override
  List<dynamic> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(List<dynamic> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$SystemBaseActionController =
      ActionController(name: 'SystemBase', context: context);

  @override
  void addCartItem(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.addCartItem');
    try {
      return super.addCartItem(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCartItem(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.removeCartItem');
    try {
      return super.removeCartItem(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDarkMode(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.changeDarkMode');
    try {
      return super.changeDarkMode(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEmail(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePassword(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeUsername(dynamic value) {
    final _$actionInfo = _$SystemBaseActionController.startAction(
        name: 'SystemBase.changeUsername');
    try {
      return super.changeUsername(value);
    } finally {
      _$SystemBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
email: ${email},
password: ${password},
username: ${username},
cart: ${cart}
    ''';
  }
}
