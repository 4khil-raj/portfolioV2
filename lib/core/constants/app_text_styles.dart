import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography styles using Plus Jakarta Sans font
/// Modern, clean typography for a professional portfolio
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _baseStyle => GoogleFonts.plusJakartaSans();

  // Display styles
  static TextStyle displayLarge(Color color) => _baseStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.5,
        height: 1.12,
      );

  static TextStyle displayMedium(Color color) => _baseStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.3,
        height: 1.16,
      );

  static TextStyle displaySmall(Color color) => _baseStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.2,
        height: 1.22,
      );

  // Headline styles
  static TextStyle headlineLarge(Color color) => _baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.25,
      );

  static TextStyle headlineMedium(Color color) => _baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.29,
      );

  static TextStyle headlineSmall(Color color) => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.33,
      );

  // Title styles
  static TextStyle titleLarge(Color color) => _baseStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.27,
      );

  static TextStyle titleMedium(Color color) => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.1,
        height: 1.33,
      );

  static TextStyle titleSmall(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // Body styles
  static TextStyle bodyLarge(Color color) => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.3,
        height: 1.6,
      );

  static TextStyle bodyMedium(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.2,
        height: 1.5,
      );

  static TextStyle bodySmall(Color color) => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.3,
        height: 1.4,
      );

  // Label styles
  static TextStyle labelLarge(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle labelMedium(Color color) => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.4,
        height: 1.33,
      );

  static TextStyle labelSmall(Color color) => _baseStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.4,
        height: 1.45,
      );

  // Custom styles
  static TextStyle heroTitle(Color color) => _baseStyle.copyWith(
        fontSize: 52,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle heroSubtitle(Color color) => _baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      );

  static TextStyle sectionTitle(Color color) => _baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle cardTitle(Color color) => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      );

  static TextStyle chipText(Color color) => _baseStyle.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.2,
      );

  static TextStyle button(Color color) => _baseStyle.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.3,
      );
}
