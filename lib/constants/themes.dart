import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor),
      bodyMedium: TextStyle(color: AppColors.textColor),
      titleLarge: TextStyle(color: AppColors.textColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyText,
    ),
    iconTheme: IconThemeData(color: AppColors.textColor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.secondaryColor,
      hintStyle: TextStyle(color: AppColors.greyText),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    dialogBackgroundColor: AppColors.darkCard,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(color: AppColors.darkText),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkText),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCard,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.darkGreyText,
    ),
    iconTheme: IconThemeData(color: AppColors.darkText),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkSecondary,
      hintStyle: TextStyle(color: AppColors.darkGreyText),
    ),
  );
}