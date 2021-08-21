import 'package:flutter/material.dart';

class TriangleClipperMe extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width / 3,
      size.height / 1.2,
      0.0,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipperMe oldClipper) => false;
}

class TriangleClipperOther extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 1.2,
      size.width,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipperOther oldClipper) => false;
}
