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

  late final _$SystemBaseActionController =
      ActionController(name: 'SystemBase', context: context);

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
  String toString() {
    return '''
isDarkMode: ${isDarkMode}
    ''';
  }
}
