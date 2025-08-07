import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- PALET WARNA ---
  static const Color _primaryLight = Color(0xFF89ABE3);
  static const Color _backgroundLight = Color(0xFFFCF6F5);
  static const Color _surfaceLight = Colors.white;
  static const Color _textPrimaryLight = Color(0xFF2A3B4D);
  static const Color _textSecondaryLight = Color(0xFF8D9AAF);

  static const Color _primaryDark = Color(0xFF89ABE3);
  static const Color _backgroundDark = Color(0xFF1A1C20);
  static const Color _surfaceDark = Color(0xFF25282E);
  static const Color _textPrimaryDark = Color(0xFFEAEAEA);
  static const Color _textSecondaryDark = Color(0xFFAAB0BB);

  // --- TEMA TERANG ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: _primaryLight,
      scaffoldBackgroundColor: _backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: _primaryLight,
        secondary: _primaryLight,
        background: _backgroundLight,
        surface: _surfaceLight,
        onPrimary: Colors.white,
        onBackground: _textPrimaryLight,
        onSurface: _textPrimaryLight,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.interTextTheme(_textTheme(_textPrimaryLight)),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: _surfaceLight,
        borderColor: Colors.grey.shade300,
        hintColor: _textSecondaryLight,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(_primaryLight, Colors.white),
      textButtonTheme: _textButtonTheme(_primaryLight),
    );
  }

  // --- TEMA GELAP ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _primaryDark,
      scaffoldBackgroundColor: _backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: _primaryDark,
        secondary: _primaryDark,
        background: _backgroundDark,
        surface: _surfaceDark,
        onPrimary: _textPrimaryDark,
        onBackground: _textPrimaryDark,
        onSurface: _textPrimaryDark,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.interTextTheme(_textTheme(_textPrimaryDark)),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: _surfaceDark,
        borderColor: Colors.grey.shade800,
        hintColor: _textSecondaryDark,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(_primaryDark, _textPrimaryDark),
      textButtonTheme: _textButtonTheme(_primaryDark),
    );
  }

  // --- KOMPONEN TEMA ---

  static TextTheme _textTheme(Color color) {
    return TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: color, letterSpacing: -0.5),
      bodyLarge: TextStyle(color: color.withOpacity(0.8)),
      bodyMedium: TextStyle(color: color),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color hintColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _primaryLight, width: 2.0),
      ),
      prefixIconColor: hintColor,
      hintStyle: TextStyle(color: hintColor, fontWeight: FontWeight.w500),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(Color backgroundColor, Color foregroundColor) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.hovered)) {
            return backgroundColor.withOpacity(0.85);
          }
          return backgroundColor;
        }),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 18),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        mouseCursor: MaterialStateProperty.all<MouseCursor>(SystemMouseCursors.click),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(Color color) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.hovered)) {
            return color.withOpacity(0.8);
          }
          return color;
        }),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
        ),
      ),
    );
  }
}
