import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static  double? screenWidth;
  static  double? screenHeight;
  //static  double defaultSize;
  static  Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight!;
    // 926 is the layout height that designer use
    return (inputHeight / 926.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth!;
    // 428 is the layout width that designer use
    return (inputWidth / 428.0) * screenWidth;
  }
  static double getProportionateFontSize(double fontSize)=> screenWidth! > 600 && screenHeight! > 1000 ? fontSize+2 : fontSize;
  static getFontStyle({double? fontSize,FontWeight? fontWeight, Color? color}){
    return TextStyle(
      fontSize: screenWidth! < 350?fontSize:screenWidth! < 500?fontSize!+1:screenWidth! < 750?fontSize!+2:fontSize!+3,
      fontWeight: fontWeight,
    );
  }

}

