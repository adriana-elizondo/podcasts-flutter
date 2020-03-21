import 'dart:math';
import 'package:flutter/material.dart';

extension RandomColor on Color {
  static Color getNewColor() {
    Random random = new Random();
    return Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}