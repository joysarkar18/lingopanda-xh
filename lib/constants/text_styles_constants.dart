import 'package:flutter/material.dart';

class PoppinsTextStyle {
  static TextStyle bold({
    double fontSize = 14.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle medium({
    double fontSize = 14.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle regular({
    double fontSize = 14.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
