import 'package:flutter/material.dart';

class AppColors {
  // Primary & Brands
  static const Color primary = Color(0xFF097CCD);
  static const Color primaryDark = Color(
    0xFF1E73B9,
  ); // Maps to both 1E73B9 and 1E73B7
  static const Color primaryButton = Color(0xFF1E88E5);
  static const Color primaryLight = Color(0xFFC9DDFF);
  static const Color blueLight = Color(0xFF3B82F6);

  // Status Colors
  static const Color success = Color(0xFF57C05C);
  static const Color danger = Color(0xFFFF393C);
  static const Color dangerLight = Color(0xFFFF4646);
  static const Color dangerLighter = Color(0xFFFF4C4F);

  // Grayscale / Text / Borders
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF817878);
  static const Color textTertiary = Color(0xFF797979);
  static const Color border = Color(0xFFD9D9D9);
  static const Color greyMedium = Color(0xFFB3B3B3);

  // Aliases for compatibility
  static const Color dangerRed = danger;
  static const Color primaryBlue = primary;
  static const Color successGreen = success;
}
