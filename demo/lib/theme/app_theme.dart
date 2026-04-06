import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Design system: monochrome + one accent color (brand blue)
/// Inspired by Apple Wallet, Revolut, Linear
class C {
  // Brand
  static const brand = Color(0xFF0066FF);
  static const brandLight = Color(0xFFE8F0FE);

  // Greyscale
  static const black = Color(0xFF000000);
  static const grey900 = Color(0xFF1A1A1A);
  static const grey700 = Color(0xFF48484A);
  static const grey500 = Color(0xFF8E8E93);
  static const grey300 = Color(0xFFC7C7CC);
  static const grey200 = Color(0xFFE5E5EA);
  static const grey100 = Color(0xFFF2F2F7);
  static const white = Color(0xFFFFFFFF);

  // Semantic (used sparingly)
  static const green = Color(0xFF34C759);
  static const red = Color(0xFFFF3B30);
  static const orange = Color(0xFFFF9500);

  // Surface
  static const bg = grey100;
  static const card = white;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: C.bg,
      primaryColor: C.brand,
      colorScheme: ColorScheme.light(primary: C.brand, secondary: C.green, surface: C.card, error: C.red),
      appBarTheme: const AppBarTheme(
        backgroundColor: C.bg,
        foregroundColor: C.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(color: C.black, fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.4),
      ),
    );
  }
}
