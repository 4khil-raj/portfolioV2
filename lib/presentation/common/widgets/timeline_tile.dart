import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Modern timeline tile widget for experience/education items
class TimelineTile extends StatefulWidget {
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
  State<TimelineTile> createState() => _TimelineTileState();
}

class _TimelineTileState extends State<TimelineTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final accentColor = widget.isCurrent ? AppColors.accent : AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            SizedBox(
              width: 32,
              child: Column(
                children: [
                  // Top connector
                  Container(
                    width: 2,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: widget.isFirst
                          ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                accentColor.withValues(alpha: 0.3),
                              ],
                            )
                          : null,
                      color: widget.isFirst
                          ? null
                          : accentColor.withValues(alpha: 0.3),
                    ),
                  ),
                  // Dot indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: widget.isCurrent ? 16 : 12,
                    height: widget.isCurrent ? 16 : 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isCurrent || _isHovered
                          ? accentColor
                          : accentColor.withValues(alpha: 0.4),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBackground
                            : AppColors.lightBackground,
                        width: 3,
                      ),
                      boxShadow: widget.isCurrent || _isHovered
                          ? [
                              BoxShadow(
                                color: accentColor.withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  // Bottom connector
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: widget.isLast
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  accentColor.withValues(alpha: 0.3),
                                  Colors.transparent,
                                ],
                              )
                            : null,
                        color: widget.isLast
                            ? null
                            : accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.lg),
            // Content card
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: AppSizes.xl),
                padding: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCard.withValues(alpha: _isHovered ? 1 : 0.8)
                      : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  border: Border.all(
                    color: widget.isCurrent || _isHovered
                        ? accentColor.withValues(alpha: 0.3)
                        : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? accentColor.withValues(alpha: isDark ? 0.15 : 0.1)
                          : (isDark
                              ? Colors.black.withValues(alpha: 0.2)
                              : Colors.black.withValues(alpha: 0.04)),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: Offset(0, _isHovered ? 8 : 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (widget.isCurrent)
                                    Container(
                                      margin: const EdgeInsets.only(right: AppSizes.sm),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.sm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.accent.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                                      ),
                                      child: Text(
                                        'CURRENT',
                                        style: AppTextStyles.labelSmall(AppColors.accent).copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      style: AppTextStyles.cardTitle(textColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSizes.xs),
                              Text(
                                widget.subtitle,
                                style: AppTextStyles.bodyMedium(accentColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSizes.md),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.md,
                            vertical: AppSizes.xs,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.lightBackground,
                            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                          ),
                          child: Text(
                            widget.duration,
                            style: AppTextStyles.labelSmall(secondaryColor),
                          ),
                        ),
                      ],
                    ),
                    if (widget.location != null) ...[
                      const SizedBox(height: AppSizes.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: secondaryColor,
                          ),
                          const SizedBox(width: AppSizes.xs),
                          Text(
                            widget.location!,
                            style: AppTextStyles.bodySmall(secondaryColor),
                          ),
                        ],
                      ),
                    ],
                    if (widget.highlights != null && widget.highlights!.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.md),
                      const Divider(height: 1),
                      const SizedBox(height: AppSizes.md),
                      ...widget.highlights!.map(
                        (highlight) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.sm),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.arrow_right_rounded,
                                  size: 18,
                                  color: accentColor,
                                ),
                              ),
                              const SizedBox(width: AppSizes.xs),
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
      ),
    );
  }
}
