import 'dart:math';
import 'package:flutter/material.dart';

class ColorRandomizer {
  static Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}
