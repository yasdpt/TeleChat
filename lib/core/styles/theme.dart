import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.blue,
      colorScheme: ColorScheme.light(
        secondary: cLightThemeSecondaryColor,
        onSecondary: const Color(0xffa2a2a2),
        onPrimary: Colors.black,
      ),
      primaryColorDark: cLightMessageMe,
      primaryColorLight: cLightMessageOther,
      dividerColor: Colors.grey[200],
      primarySwatch: Colors.indigo,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[400], //Color(0xFFFFFFFF),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      fontFamily: 'Vazir',
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Vazir',
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Vazir',
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Vazir',
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          fontFamily: 'Vazir',
        ),
        headline5: TextStyle(
            color: Color(0xffa2a2a2),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Vazir',
            locale: Locale('fa', '')),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: cDarkThemeColor,
      accentColor: cTitleBlue,
      scaffoldBackgroundColor: cDarkThemeScaffold,
      colorScheme: ColorScheme.light(
        secondary: cDarkThemeSecondaryColor,
        onPrimary: Colors.white,
        onSecondary: const Color(0xff6b7b8c),
      ),
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: cDarkThemeColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      primaryColorDark: cDarkMessageMe,
      primaryColorLight: cDarkMessageOther,
      dividerColor: Color(0xff17212b),
      fontFamily: 'Vazir',
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Vazir',
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Vazir',
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Vazir',
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          fontFamily: 'Vazir',
        ),
        headline5: TextStyle(
          color: Color(0xff6b7b8c),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Vazir',
          locale: Locale('fa', ''),
        ),
      ),
    );
  }
}
