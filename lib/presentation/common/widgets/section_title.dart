import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Modern 2025 section title with gradient accent
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centerAlign;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.centerAlign = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment:
          centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Main title
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              textColor,
              textColor.withValues(alpha: 0.8),
            ],
          ).createShader(bounds),
          child: Text(
            _getDisplayTitle(title),
            style: AppTextStyles.headlineLarge(Colors.white),
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSizes.sm),
          Text(
            subtitle!,
            style: AppTextStyles.bodyMedium(secondaryColor),
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          ),
        ],
      ],
    );
  }

  String _getDisplayTitle(String title) {
    switch (title.toLowerCase()) {
      case 'about':
        return 'About Me';
      case 'experience':
        return 'Work Experience';
      case 'skills':
        return 'Skills & Expertise';
      case 'education':
        return 'Education';
      case 'contact':
        return 'Let\'s Connect';
      default:
        return title;
    }
  }
}
