import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF5B4DFF);
  static const Color primaryLight = Color(0xFF7B6DFF);
  static const Color primaryDark = Color(0xFF4A3DCC);

  // Background Colors
  static const Color darkBg = Color(0xFF0F0E1A);
  static const Color darkSurfaceLight = Color(0xFF1A1A2E);
  static const Color darkSurfaceDark = Color(0xFF0F0E1A);
  
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightSurfaceLight = Color(0xFFFFFFFF);
  static const Color lightSurfaceDark = Color(0xFFF5F5F5);

  // Text Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8B8B9B);
  static const Color darkTextTertiary = Color(0xFF6B6B7B);

  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightTextTertiary = Color(0xFF999999);

  // Border Colors
  static const Color darkBorder = Color(0xFF3D3D5C);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Accent Colors
  static const Color accentPurple = Color(0xFF5B4DFF);
  static const Color accentRed = Color(0xFFFF6B6B);
  static const Color accentGreen = Color(0xFF51CF66);
  static const Color accentOrange = Color(0xFFFF922B);

  // Special Colors
  static const Color dividerDark = Color(0xFF3D3D5C);
  static const Color dividerLight = Color(0xFFE0E0E0);
  
  static const Color errorColor = Color(0xFFFF6B6B);
  static const Color successColor = Color(0xFF51CF66);
  static const Color warningColor = Color(0xFFFF922B);
  static const Color infoColor = Color(0xFF5B4DFF);

  // Gradient Colors
  static const LinearGradient gradientPurpleBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6B5B95),
      Color(0xFF2A3D5C),
    ],
  );
}