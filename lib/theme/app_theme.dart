import 'package:flutter/material.dart';

/// Editorial, warm paper-and-ink theme for SetuLingo.
/// Strictly avoids any Kannada script fonts per project specification.
class AppTheme {
  AppTheme._();

  // Core Editorial Palette
  static const Color paper = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF3EFE6);
  static const Color ink = Color(0xFF181A1F);
  static const Color inkMuted = Color(0xFF5A5E66);
  static const Color inkSubtle = Color(0xFF8A8E96);
  static const Color border = Color(0xFFE4DFD5);
  static const Color borderStrong = Color(0xFFCFC8BA);

  // Accents
  static const Color terracotta = Color(0xFFC84B31);
  static const Color terracottaSoft = Color(0xFFFAECE8);
  static const Color sage = Color(0xFF2E6F5E);
  static const Color sageSoft = Color(0xFFE8F2EF);
  static const Color ochre = Color(0xFFB37A1E);
  static const Color ochreSoft = Color(0xFFFBF3E4);
  static const Color indigo = Color(0xFF2F4875);
  static const Color indigoSoft = Color(0xFFEBEEF5);
  static const Color danger = Color(0xFFB3261E);
  static const Color dangerSoft = Color(0xFFFCECEB);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: terracotta,
      brightness: Brightness.light,
      surface: surface,
      primary: terracotta,
      onPrimary: Colors.white,
      secondary: sage,
      onSecondary: Colors.white,
      error: danger,
      onError: Colors.white,
      outline: border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: paper,
      appBarTheme: const AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: terracotta, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: danger),
        ),
        labelStyle: const TextStyle(color: inkMuted),
        hintStyle: const TextStyle(color: inkSubtle),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: terracotta,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          side: const BorderSide(color: borderStrong),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: ink,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          color: ink,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          height: 1.25,
        ),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: ink,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: ink,
          fontSize: 15,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          color: inkMuted,
          fontSize: 14,
          height: 1.45,
        ),
        labelLarge: TextStyle(
          color: ink,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: inkSubtle,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
