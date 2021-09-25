import 'package:flutter/material.dart';

import 'colors.dart';
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

InputDecoration defaultInputDecorationUnderline(
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
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
    counterStyle: Theme.of(context).textTheme.headline3,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
    errorStyle: tTextSmall.copyWith(color: cPrimaryRed),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
  );
}

InputDecoration defaultInputDecorationSuffix(
  BuildContext context,
  String label, {
  TextStyle textStyle,
  Color borderColor,
  Text error,
  Color backgroudColor = Colors.white,
  double verticalPadding,
  double horizontalPadding,
  Icon suffixIcon,
  TextDirection hintTextDirection = TextDirection.ltr,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: label,
    suffixIcon: Padding(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: suffixIcon,
    ),
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
