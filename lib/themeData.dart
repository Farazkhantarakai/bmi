import 'package:flutter/material.dart';

class Theme {
  static TextTheme lightTextTheme = const TextTheme(
      headline4: TextStyle(
          fontFamily: 'NotoSerif-Bold',
          fontSize: 5,
          fontWeight: FontWeight.w900),
      bodyText1: TextStyle(fontFamily: 'NotoSerif-Bold', color: Colors.black),
      bodyText2:
          TextStyle(fontFamily: 'NotoSerif-Regular', color: Colors.black),
      labelMedium:
          TextStyle(fontFamily: 'NotoSerif-Bold', fontWeight: FontWeight.w700));

  static ThemeData light() {
    return ThemeData(brightness: Brightness.light);
  }
}
