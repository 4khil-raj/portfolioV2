import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Clean, minimal Education section
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final education = state.education;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.education),
                  const SizedBox(height: AppSizes.xxl),
                  // Education cards
                  isMobile
                      ? Column(
                          children: education.asMap().entries.map((entry) {
                            final index = entry.key;
                            final edu = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index < education.length - 1 ? AppSizes.lg : 0,
                              ),
                              child: _EducationCard(
                                degree: edu.degree,
                                institution: edu.institution,
                                duration: edu.duration,
                                description: edu.description,
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            );
                          }).toList(),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: education.asMap().entries.map((entry) {
                            final index = entry.key;
                            final edu = entry.value;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index > 0 ? AppSizes.md : 0,
                                  right: index < education.length - 1 ? AppSizes.md : 0,
                                ),
                                child: _EducationCard(
                                  degree: edu.degree,
                                  institution: edu.institution,
                                  duration: edu.duration,
                                  description: edu.description,
                                  isDark: isDark,
                                  textColor: textColor,
                                  secondaryColor: secondaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EducationCard extends StatefulWidget {
  final String degree;
  final String institution;
  final String duration;
  final String? description;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;

  const _EducationCard({
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.3)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    vertical: AppSizes.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Text(
                    widget.duration,
                    style: AppTextStyles.labelSmall(AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            // Degree
            Text(
              widget.degree,
              style: AppTextStyles.titleMedium(widget.textColor),
            ),
            const SizedBox(height: AppSizes.xs),
            // Institution
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: widget.secondaryColor,
                ),
                const SizedBox(width: AppSizes.xs),
                Expanded(
                  child: Text(
                    widget.institution,
                    style: AppTextStyles.bodySmall(widget.secondaryColor),
                  ),
                ),
              ],
            ),
            if (widget.description != null) ...[
              const SizedBox(height: AppSizes.md),
              Text(
                widget.description!,
                style: AppTextStyles.bodySmall(widget.secondaryColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
