import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // dynamic height -> padding and margin
  static double height120 = screenHeight/(screenHeight/120);
  static double height40 = screenHeight/(screenHeight/40);
  static double height50 = screenHeight/(screenHeight/50);

  // dynamic width -> padding and margin
  static double width20 = screenWidth/(screenWidth/40);
  static double width150 = screenWidth/(screenWidth/150);

  // dynamic font size
  static double font28 = screenHeight/(screenHeight/28);
  static double font20 = screenHeight/(screenHeight/20);

  // radius
  static double radius30 = screenHeight/(screenHeight/30);
}