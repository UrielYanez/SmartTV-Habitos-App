import 'package:flutter/material.dart';

class TvTheme {
  static const Color background = Color(0xFF0F172A); // Slate 900 for TV background
  static const Color surface = Color(0xFF1E293B);    // Slate 800 for cards
  static const Color surfaceElevated = Color(0xFF334155); // Slate 700 for focused elements

  static const Color primary = Color(0xFF6366F1);     // Neon Indigo (Brand color)
  static const Color primaryFocused = Color(0xFF818CF8); // Indigo 400
  static const Color success = Color(0xFF10B981);     // Emerald Green
  static const Color error = Color(0xFFEF4444);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        surface: surface,
        error: error,
        onPrimary: Colors.white,
        onSurface: textPrimary,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textSecondary,
        ),
      ),
    );
  }
}
