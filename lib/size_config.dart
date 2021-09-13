import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getProportionteScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;

  return (inputHeight / 896.0) * screenHeight;
}

double getProportionScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;

  return (inputWidth / 414.0) * screenWidth;
}
