import 'package:flutter/material.dart';

class ColorsPalette {
  static const _primaryColorValue = 0xffe1b438;

  static const primarySwatch = MaterialColor(
    _primaryColorValue,
    {
      50: Color(0xffe1b438),
      100: Color(0xffe1b438),
      200: Color(0xffe1b438),
      300: Color(0xffe1b438),
      400: Color(0xffe1b438),
      500: Color(_primaryColorValue),
      600: Color(0xffdfb136),
      700: Color(0xffdfb136),
      800: Color(0xffdfb136),
      900: Color(0xffdfb136),
    },
  );

  static const primaryColor = Color(_primaryColorValue);
  static const accentColor = Color(0xFFDED85A);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF0F0E0E);

  static const lightGrey = Color(0xFFF0EEEE);
  static const lightpre = Color(0xFFE6EAED);
  static const grey = Color(0xFFECECEC);
  static const darkGrey = Color(0xFF9E9E9E);
  static const customGrey = Color(0xFF383434);
  static const extraDarkGrey = Color(0xFF383434);
  static const veryDarkGrey = Color(0XFF4F5050);

  static const green = Color(0xFF4CAF50);
  static const darkGreen = Color(0xFF00881D);
  static const red = Color(0xFFBB2800);
  static const yellow = Color(0xFFF9B32F);
}
