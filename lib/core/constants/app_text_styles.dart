import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern minimalistic typography using Inter font
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _baseStyle => GoogleFonts.inter();

  // Display - Large hero text
  static TextStyle displayLarge(Color color) => _baseStyle.copyWith(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -2,
        height: 1.1,
      );

  static TextStyle displayMedium(Color color) => _baseStyle.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -1.5,
        height: 1.15,
      );

  static TextStyle displaySmall(Color color) => _baseStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -1,
        height: 1.2,
      );

  // Headline
  static TextStyle headlineLarge(Color color) => _baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.5,
        height: 1.25,
      );

  static TextStyle headlineMedium(Color color) => _baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.5,
        height: 1.3,
      );

  static TextStyle headlineSmall(Color color) => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.35,
      );

  // Title
  static TextStyle titleLarge(Color color) => _baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      );

  static TextStyle titleMedium(Color color) => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      );

  static TextStyle titleSmall(Color color) => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      );

  // Body
  static TextStyle bodyLarge(Color color) => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.6,
      );

  static TextStyle bodyMedium(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.6,
      );

  static TextStyle bodySmall(Color color) => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  // Label
  static TextStyle labelLarge(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.1,
        height: 1.4,
      );

  static TextStyle labelMedium(Color color) => _baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.2,
        height: 1.4,
      );

  static TextStyle labelSmall(Color color) => _baseStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.3,
        height: 1.4,
      );

  // Custom - Hero
  static TextStyle heroTitle(Color color) => GoogleFonts.spaceGrotesk(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.05,
        letterSpacing: -2,
      );

  static TextStyle heroSubtitle(Color color) => _baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  // Section
  static TextStyle sectionTitle(Color color) => GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.2,
        letterSpacing: -1,
      );

  static TextStyle cardTitle(Color color) => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      );

  static TextStyle chipText(Color color) => _baseStyle.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle button(Color color) => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.2,
      );

  // Mono for code/stats
  static TextStyle mono(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle statNumber(Color color) => GoogleFonts.spaceGrotesk(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -1,
      );
}
