import 'package:flutter/material.dart';

/// Modern minimalistic color palette
/// Clean, sophisticated colors with subtle gradients
class AppColors {
  AppColors._();

  // Primary accent - Elegant teal/cyan
  static const Color primary = Color(0xFF0EA5E9);
  static const Color primaryLight = Color(0xFF38BDF8);
  static const Color primaryDark = Color(0xFF0284C7);

  // Secondary accent - Soft violet
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color secondaryLight = Color(0xFFA78BFA);

  // Accent colors
  static const Color accent = Color(0xFF10B981);
  static const Color accentWarm = Color(0xFFF59E0B);
  static const Color accentPink = Color(0xFFEC4899);

  // For backward compatibility
  static const Color primaryOrange = Color(0xFF0EA5E9);
  static const Color primaryTeal = Color(0xFF10B981);
  static const Color primaryBlue = Color(0xFF0EA5E9);
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryCyan = Color(0xFF06B6D4);

  // Light theme - Clean whites and soft grays
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextMuted = Color(0xFF94A3B8);
  static const Color lightDivider = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFF1F5F9);

  // Dark theme - Deep, rich darks
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);
  static const Color darkDivider = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF334155);

  // Gradient colors
  static const Color gradientStart = Color(0xFF0EA5E9);
  static const Color gradientMiddle = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFFEC4899);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Skill category colors - Harmonious palette
  static const List<Color> skillColors = [
    Color(0xFF0EA5E9), // Sky
    Color(0xFF8B5CF6), // Violet
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFF6366F1), // Indigo
    Color(0xFFEF4444), // Red
  ];
}
