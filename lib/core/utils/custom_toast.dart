import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void kShowToast(
  String message, {
  int seconds,
}) {
  Fluttertoast.showToast(
    msg: message,
    webPosition: "center",
    webBgColor: '#000000',
    toastLength: seconds != null ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: seconds ?? 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
