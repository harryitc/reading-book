import 'package:flutter/material.dart';

/// Centralized color scheme for StoryNest app
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Light Mode Colors
  static const Color primaryLight = Color(0xFF6B9BD1); // Pastel Blue
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color secondaryLight = Color(0xFF7FC9E0); // Light Cyan
  static const Color surfaceLight = Color(0xFFFBFBFB);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color errorLight = Color(0xFFB3261E);

  // Dark Mode Colors
  static const Color primaryDark = Color(0xFF5B8BC0);
  static const Color onPrimaryDark = Color(0xFFF5F5F5);
  static const Color secondaryDark = Color(0xFF6BA8C4);
  static const Color surfaceDark = Color(0xFF1F1F1F);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color errorDark = Color(0xFFF2B8B5);

  // Additional Colors
  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF616161);
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color hintColor = Color(0xFF9E9E9E);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFFC107);
  static const Color infoBlue = Color(0xFF2196F3);
}

/// Light color scheme
class LightColorScheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    onPrimary: AppColors.onPrimaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.textPrimary,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimary,
    background: AppColors.backgroundLight,
    onBackground: AppColors.textPrimary,
    error: AppColors.errorLight,
    onError: AppColors.onPrimaryLight,
  );
}

/// Dark color scheme
class DarkColorScheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    onPrimary: AppColors.onPrimaryDark,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onPrimaryDark,
    background: AppColors.backgroundDark,
    onBackground: AppColors.onPrimaryDark,
    error: AppColors.errorDark,
    onError: AppColors.backgroundDark,
  );
}
