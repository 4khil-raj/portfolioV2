import 'package:flutter/material.dart';

/// Next-Gen 2025/2026 Color System
/// Featuring deep space darks, neon cyan & violet gradients, and glassmorphic accents
class AppColors {
  AppColors._();

  // Primary accent - Electric Cyan
  static const Color primary = Color(0xFF06B6D4);
  static const Color primaryLight = Color(0xFF38BDF8);
  static const Color primaryDark = Color(0xFF0284C7);

  // Secondary accent - Deep Neon Violet
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color secondaryLight = Color(0xFFA78BFA);

  // Vibrant Accents
  static const Color accent = Color(0xFF10B981); // Emerald
  static const Color accentWarm = Color(0xFFF59E0B); // Amber
  static const Color accentPink = Color(0xFFEC4899); // Neon Pink
  static const Color accentIndigo = Color(0xFF6366F1); // Indigo

  // For backward compatibility
  static const Color primaryOrange = Color(0xFF06B6D4);
  static const Color primaryTeal = Color(0xFF10B981);
  static const Color primaryBlue = Color(0xFF38BDF8);
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryCyan = Color(0xFF06B6D4);

  // Light Theme - Crisp Off-White & Soft Slate
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);
  static const Color lightDivider = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Dark Theme - Deep Space Dark (#080C14 / #0F172A)
  static const Color darkBackground = Color(0xFF080C14);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF131C2E);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);
  static const Color darkDivider = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF1E293B);

  // Glassmorphism & Neon Glow Colors
  static Color darkGlassCard = const Color(0xFF0F172A).withValues(alpha: 0.7);
  static Color darkGlassBorder = const Color(0xFF38BDF8).withValues(alpha: 0.15);
  static Color lightGlassCard = const Color(0xFFFFFFFF).withValues(alpha: 0.85);
  static Color lightGlassBorder = const Color(0xFF06B6D4).withValues(alpha: 0.12);

  // Vibrant Gradient Palettes
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
  );

  static const LinearGradient heroGlowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x3306B6D4), Color(0x338B5CF6), Color(0x22EC4899)],
  );

  static const Color gradientStart = Color(0xFF06B6D4);
  static const Color gradientMiddle = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFFEC4899);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF38BDF8);

  // Skill category colors
  static const List<Color> skillColors = [
    Color(0xFF06B6D4), // Cyan
    Color(0xFF8B5CF6), // Violet
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
    Color(0xFF6366F1), // Indigo
    Color(0xFF38BDF8), // Sky
    Color(0xFFEF4444), // Red
  ];
}

