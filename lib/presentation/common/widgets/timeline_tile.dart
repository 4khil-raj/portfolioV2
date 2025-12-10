import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// A timeline tile widget for displaying experience or education items
class TimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String? location;
  final List<String>? highlights;
  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  const TimelineTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    this.location,
    this.highlights,
    this.isFirst = false,
    this.isLast = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and dot
          SizedBox(
            width: 24,
            child: Column(
              children: [
                // Top line
                if (!isFirst)
                  Container(
                    width: AppSizes.timelineLineWidth,
                    height: 20,
                    color: AppColors.primaryOrange.withValues(alpha: 0.3),
                  )
                else
                  const SizedBox(height: 20),
                // Dot
                Container(
                  width: isCurrent
                      ? AppSizes.timelineDotSizeLarge
                      : AppSizes.timelineDotSize,
                  height: isCurrent
                      ? AppSizes.timelineDotSizeLarge
                      : AppSizes.timelineDotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent
                        ? AppColors.primaryOrange
                        : AppColors.primaryOrange.withValues(alpha: 0.5),
                    border: isCurrent
                        ? Border.all(
                            color: AppColors.primaryOrange.withValues(alpha: 0.3),
                            width: 4,
                          )
                        : null,
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.primaryOrange.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
                // Bottom line
                Expanded(
                  child: Container(
                    width: AppSizes.timelineLineWidth,
                    color: isLast
                        ? Colors.transparent
                        : AppColors.primaryOrange.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.md),
          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSizes.lg),
              padding: const EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCard.withValues(alpha: 0.6)
                    : AppColors.lightCard,
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                border: Border.all(
                  color: isCurrent
                      ? AppColors.primaryOrange.withValues(alpha: 0.3)
                      : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
                  width: isCurrent ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with title and duration
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTextStyles.cardTitle(textColor),
                            ),
                            const SizedBox(height: AppSizes.xs),
                            Text(
                              subtitle,
                              style: AppTextStyles.bodyMedium(secondaryColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.md,
                          vertical: AppSizes.xs,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppColors.primaryOrange.withValues(alpha: 0.15)
                              : (isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightBackground),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusFull),
                        ),
                        child: Text(
                          duration,
                          style: AppTextStyles.labelSmall(
                            isCurrent ? AppColors.primaryOrange : secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (location != null) ...[
                    const SizedBox(height: AppSizes.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: AppSizes.iconSm,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Text(
                          location!,
                          style: AppTextStyles.bodySmall(secondaryColor),
                        ),
                      ],
                    ),
                  ],
                  if (highlights != null && highlights!.isNotEmpty) ...[
                    const SizedBox(height: AppSizes.md),
                    ...highlights!.map(
                      (highlight) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                            const SizedBox(width: AppSizes.sm),
                            Expanded(
                              child: Text(
                                highlight,
                                style: AppTextStyles.bodySmall(textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
