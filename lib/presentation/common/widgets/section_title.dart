import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// A styled section title widget with an accent underline
class SectionTitle extends StatelessWidget {
  final String title;
  final bool centerAlign;

  const SectionTitle({
    super.key,
    required this.title,
    this.centerAlign = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Column(
      crossAxisAlignment:
          centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitle(textColor),
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: AppSizes.sm),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
        ),
      ],
    );
  }
}
