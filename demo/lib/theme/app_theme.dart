import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // Primary palette - subtle, sophisticated
  static const primary = Color(0xFF007AFF);
  static const secondary = Color(0xFF34C759);
  static const accent = Color(0xFFFF9F0A);
  static const danger = Color(0xFFFF3B30);
  static const purple = Color(0xFF5856D6);
  static const teal = Color(0xFF64D2FF);
  static const pink = Color(0xFFFF2D55);
  static const indigo = Color(0xFF5E5CE6);

  // Backgrounds
  static const background = Color(0xFFF2F2F7);
  static const cardBg = Colors.white;
  static const elevatedBg = Color(0xFFFFFFFF);

  // Text hierarchy
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF3C3C43);
  static const textTertiary = Color(0xFF8E8E93);
  static const textQuaternary = Color(0xFFC7C7CC);

  // Separators
  static const separator = Color(0xFFC6C6C8);
  static const separatorLight = Color(0xFFE5E5EA);

  // Semantic
  static const success = Color(0xFF34C759);
  static const earning = Color(0xFF30D158);

  // Gradients
  static const gradientBlue = [Color(0xFF007AFF), Color(0xFF5AC8FA)];
  static const gradientPurple = [Color(0xFF5856D6), Color(0xFFAF52DE)];
  static const gradientGreen = [Color(0xFF34C759), Color(0xFF30D158)];
  static const gradientOrange = [Color(0xFFFF9F0A), Color(0xFFFF6723)];
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: '.SF Pro Display',
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.cardBg,
        error: AppColors.danger,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF2F2F7),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.6),
        unselectedLabelStyle: TextStyle(fontSize: 10, height: 1.6),
        elevation: 0,
      ),
    );
  }
}
