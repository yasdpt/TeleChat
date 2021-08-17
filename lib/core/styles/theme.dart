import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.indigo,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff1e88e5), //Color(0xFFFFFFFF),
        brightness: Brightness.dark,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: cDarkThemeColor,
      scaffoldBackgroundColor: cDarkThemeScaffold,
      primarySwatch: Colors.indigo,
      appBarTheme: AppBarTheme(
        backgroundColor: cDarkThemeColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
