import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CustomRect extends CustomClipper<Path> {

  double index;
  CustomRect(double index){
    this.index = index;
  }
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = new Path();
    path
      ..lineTo(0.0, size.height - index)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) => true;
}

class DiagonClipper extends CustomClipper<Path> {

  double index;
  DiagonClipper(double index){
    this.index = index;
  }
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = new Path();
    path
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..lineTo(40.0, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) => true;
}
