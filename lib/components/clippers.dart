import 'package:flutter/material.dart';


class AbsoluteClipper extends CustomClipper<Rect>{
  Path path = new Path();
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}