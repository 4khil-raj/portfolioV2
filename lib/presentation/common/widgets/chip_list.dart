import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// A widget that displays a list of chips with custom styling
class ChipList extends StatelessWidget {
  final List<String> items;
  final Color? chipColor;
  final bool wrap;

  const ChipList({
    super.key,
    required this.items,
    this.chipColor,
    this.wrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = chipColor?.withValues(alpha: 0.15) ??
        (isDark
            ? AppColors.primaryOrange.withValues(alpha: 0.15)
            : AppColors.primaryOrange.withValues(alpha: 0.1));
    final textColor = chipColor ?? AppColors.primaryOrange;

    if (wrap) {
      return Wrap(
        spacing: AppSizes.sm,
        runSpacing: AppSizes.sm,
        children: items.map((item) => _buildChip(item, bgColor, textColor)).toList(),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: AppSizes.sm),
                  child: _buildChip(item, bgColor, textColor),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(
          color: textColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.chipText(textColor),
      ),
    );
  }
}
