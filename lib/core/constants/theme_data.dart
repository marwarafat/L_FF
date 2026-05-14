// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class AppThemes {
  static final ligthTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    fontFamily: "Abhaya Libre",
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: TextTheme(
      titleLarge: AppStyles.titleTextStyle,
      titleMedium: AppStyles.subTitleTextStyle,
    ),

    buttonTheme: ButtonThemeData(buttonColor: AppColors.primaryColor),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(0.3),
      selectionHandleColor: AppColors.primaryColor,
    ),
  );
}
