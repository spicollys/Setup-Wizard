import 'package:flutter/material.dart';

class Constants {
  static const Color blueGrey100 = Color(0xFFCFD8DC);
  static const Color blueGrey200 = Color(0xFFB0BEC5);
  static const Color blueGrey400 = Color(0xFF78909C);
  static const Color blueGrey600 = Color(0xFF546E7A);
  static const Color blueGrey700 = Color(0xFF455A64);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey600 = Color(0xFF757575);
  static const Color yellow700 = Color(0xFFFBC02D);

  static final LinearGradient blueGreyGradientPattern = LinearGradient(
    begin: Alignment.topCenter,
    colors: [
      Colors.blueGrey[200],
      Colors.blueGrey[300],
      Colors.blueGrey[400],
      Colors.blueGrey,
      Colors.blueGrey[600],
    ],
  );
}
