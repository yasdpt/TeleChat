import 'package:flutter/material.dart';

import 'colors.dart';
import 'style_consts.dart';
import 'text_styles.dart';

InputDecoration defaultInputDecoration(
  BuildContext context,
  String label, {
  TextStyle textStyle,
  Color borderColor,
  Text error,
  Color backgroudColor = Colors.white,
  double verticalPadding,
  double horizontalPadding,
  TextDirection hintTextDirection = TextDirection.ltr,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: label,
    hintStyle: textStyle ??
        const TextStyle(
            color: cDarkGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Vazir'),
    hintTextDirection: hintTextDirection,
    fillColor: backgroudColor,
    focusColor: backgroudColor,
    filled: true,
    isDense: true,
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: backgroudColor,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
    counterText: '',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: backgroudColor),
      borderRadius: BorderRadius.circular(0),
    ),
    errorStyle: tTextSmall.copyWith(color: cPrimaryRed),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: backgroudColor),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: backgroudColor),
      borderRadius: BorderRadius.circular(0),
    ),
  );
}

InputDecoration bottomSheetInputDecoration(
  BuildContext context,
  String label, {
  TextStyle textStyle,
  Color borderColor,
  Text error,
  double verticalPadding,
  double horizontalPadding,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: label,
    contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 11, vertical: verticalPadding ?? 8),
    hintStyle: textStyle ??
        const TextStyle(
          color: cBrownGrey,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
    hintTextDirection: TextDirection.rtl,
    fillColor: Colors.white,
    focusColor: Colors.white,
    filled: true,
    isDense: true,
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: cDivider,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    counterText: '',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? cDarkMint),
      borderRadius: BorderRadius.circular(10),
    ),
    errorStyle: tTextSmall.copyWith(color: cPrimaryRed),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: cPrimaryRed),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: cPrimaryRed),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration bottomSheetIconInputDecoration(
  BuildContext context,
  String label,
  Widget prefix, {
  TextStyle textStyle,
  Color borderColor,
  Text error,
  double verticalPadding,
  double horizontalPadding,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: label,
    prefixIcon: prefix,
    prefixIconConstraints: BoxConstraints.loose(Size(34, 30)),
    contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 11, vertical: verticalPadding ?? 8),
    hintStyle: textStyle ??
        const TextStyle(
          color: cBrownGrey,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
    hintTextDirection: TextDirection.rtl,
    fillColor: Colors.white,
    focusColor: Colors.white,
    filled: true,
    isDense: true,
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: cDivider,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    counterText: '',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? cDarkMint),
      borderRadius: BorderRadius.circular(10),
    ),
    errorStyle: tTextSmall.copyWith(color: cPrimaryRed),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: cPrimaryRed),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: cPrimaryRed),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration prefixInputDecoration(
  BuildContext context,
  String label,
  Widget prefixIcon, {
  TextStyle textStyle,
  Color borderColor,
  Text error,
  double verticalPadding,
  double horizontalPadding,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: label,
    contentPadding: EdgeInsets.symmetric(
      horizontal: horizontalPadding ?? 14,
      vertical: verticalPadding ?? 11.5,
    ),
    hintStyle: textStyle ??
        const TextStyle(
          color: cBoxShadowColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
    fillColor: cPaleGrey,
    focusColor: cPaleGrey,
    filled: true,
    counter: Container(),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: cDivider,
      ),
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? cDarkMint),
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
  );
}
