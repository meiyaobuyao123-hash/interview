import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const primary = Color(0xFF0A84FF);
  static const secondary = Color(0xFF34C759);
  static const accent = Color(0xFFFF9500);
  static const danger = Color(0xFFFF3B30);
  static const background = Color(0xFFF2F2F7);
  static const cardBg = Colors.white;
  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF8E8E93);
  static const textTertiary = Color(0xFFAEAEB2);
  static const divider = Color(0xFFE5E5EA);
  static const success = Color(0xFF34C759);
  static const earningGreen = Color(0xFF30D158);
  static const purple = Color(0xFF5856D6);
  static const teal = Color(0xFF5AC8FA);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.cardBg,
        error: AppColors.danger,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
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
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: AppColors.textPrimary),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: AppColors.textPrimary),
        headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: AppColors.textPrimary),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.4, color: AppColors.textPrimary),
        titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.4, color: AppColors.textPrimary),
        titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -0.2, color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -0.4, color: AppColors.textPrimary),
        bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.2, color: AppColors.textPrimary),
        bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: -0.1, color: AppColors.textSecondary),
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -0.2),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
      ),
    );
  }
}
