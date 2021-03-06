import 'package:flutter/material.dart';
import 'dart:math';

const Color cBoxShadowColor = Color(0xff979797);
const Color cDarkMint = Color(0xff4ebf85);
const Color cDivider = Color(0xffc2c2c2);
const Color cPaleGrey = Color(0xfff3f6f9);
const Color cLightText = Color(0xff6e6e6e);
const Color cDarkGreyBlue = Color(0xff324a5b);
const Color cNotificationsRed = Color(0xffff4242);
const Color cDarkWhite = Color(0xfff8f8f8);
const Color cPaginationIndicator = Color(0xff8e8e8e);
const Color cTangerine = Color(0xfffd8813);
const Color cOceanBlue = Color(0xff0078a6);
const Color cBrightLigtBlue = Color(0xff3ccaed);
const Color cDarkGrey = Color(0xff8b8b8b);
const Color cBottomSheetHandle = Color(0xffd4d4d4);
const Color cLightOrange = Color(0xffff5050);
const Color cDropDownSelected = Color(0xff5b5b5b);
const Color cPrimaryRed = Color(0xffff2a2a);
const Color cOrangeYellow = Color(0xfffdb813);
const Color cProgressEmpty = Color(0xffeaeaea);
const Color cDarkRed = Color(0xffff0000);
const Color cSeondaryRed = Color(0xffff4545);
const Color cBrownGrey = Color(0xff979797);
const Color cOrangeBorder = Color(0xffff8a00);
const Color cLightRed = Color(0xffff2d2d);
const Color cItemBorder = Color(0xffebebeb);

const Color cDarkThemeColor = Color(0xff212d3b);
const Color cDarkThemeScaffold = Color(0xff1d2733);
const Color cDarkThemeSecondaryColor = Color(0xff405361);
const Color cLightThemeSecondaryColor = Color(0xffbbbbbb);
const Color cLightMessageMe = Color(0xffeeffdd);
const Color cLightMessageOther = Color(0xffffffff);
const Color cDarkMessageMe = Color(0xff3f6187);
const Color cDarkMessageOther = Color(0xff222e3a);
const Color cTitleBlue = Color(0xff40a7e3);
const Color cForwardColor = Color(0xff7eb7e4);

List<Color> colors = [
  Color(0xffff4545),
  Color(0xff3ccaed),
  Color(0xff40a7e3),
  Color(0xff4ebf85),
  Colors.amber[900],
  Colors.brown,
  Colors.deepOrangeAccent,
  Colors.purple,
  Colors.teal,
  Colors.yellow[700],
];

Color getRandomColor() {
  final random = Random();
  int index = random.nextInt(9);
  return colors[index];
}
