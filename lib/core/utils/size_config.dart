
import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockWidth = 0;
  static double blockHeight = 0;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);

    // Safety check
    if (mediaQuery == null) return;

    final size = mediaQuery.size;
    screenWidth = size.width;
    screenHeight = size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }
}
