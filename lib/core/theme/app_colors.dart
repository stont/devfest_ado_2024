// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Google Brand Colors
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleRed = Color(0xFFDB4437);
  static const Color googleYellow = Color(0xFFF4B400);
  static const Color googleGreen = Color(0xFF0F9D58);

  // Derived Colors
  static final Color googleBlueLighter = googleBlue.withOpacity(0.1);
  static final Color googleRedLighter = googleRed.withOpacity(0.1);
  static final Color googleYellowLighter = googleYellow.withOpacity(0.1);
  static final Color googleGreenLighter = googleGreen.withOpacity(0.1);
}