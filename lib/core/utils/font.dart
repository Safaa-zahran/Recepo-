import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NSTextStyles {
  static const font = 'nunito-sans.bold';

  static TextStyle body = TextStyle(
    color: ColorsPalette.white,
    fontFamily: font,
    fontSize: 17.sp,
    letterSpacing: -0.43,
  );
  static TextStyle callout = TextStyle(
    fontFamily: font,
    color: ColorsPalette.white,
    fontSize: 15.sp,
    letterSpacing: -0.31,
  );
  static TextStyle med = TextStyle(
    fontFamily: font,
    fontSize: 10.sp,
    letterSpacing: -0.20,
    color: ColorsPalette.lightGrey
  );
  static TextStyle caption = TextStyle(
    fontSize: 7.sp,
    color: ColorsPalette.darkGrey,
  );
}