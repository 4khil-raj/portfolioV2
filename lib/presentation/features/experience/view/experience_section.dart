import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Clean, minimal Experience section
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final experiences = state.experiences;

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
                  const SectionTitle(title: AppStrings.experience),
                  const SizedBox(height: AppSizes.xxl),
                  // Experience cards
                  ...experiences.asMap().entries.map((entry) {
                    final index = entry.key;
                    final experience = entry.value;
                    return _ExperienceCard(
                      role: experience.role,
                      company: experience.company,
                      duration: experience.duration,
                      location: experience.location,
                      highlights: experience.highlights,
                      isCurrent: experience.isCurrent,
                      isLast: index == experiences.length - 1,
                      isDark: isDark,
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final String role;
  final String company;
  final String duration;
  final String location;
  final List<String> highlights;
  final bool isCurrent;
  final bool isLast;
  final bool isDark;

  const _ExperienceCard({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.highlights,
    required this.isCurrent,
    required this.isLast,
    required this.isDark,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : AppSizes.lg),
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
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company icon
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: const Icon(
                    Icons.work_outline_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                // Title and company
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.role,
                              style: AppTextStyles.titleMedium(textColor),
                            ),
                          ),
                          if (widget.isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.sm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                              ),
                              child: Text(
                                'Current',
                                style: AppTextStyles.labelSmall(AppColors.accent),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        widget.company,
                        style: AppTextStyles.bodyMedium(AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            // Duration and location
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.xs),
                Text(
                  widget.duration,
                  style: AppTextStyles.bodySmall(secondaryColor),
                ),
                const SizedBox(width: AppSizes.lg),
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.xs),
                Text(
                  widget.location,
                  style: AppTextStyles.bodySmall(secondaryColor),
                ),
              ],
            ),
            if (widget.highlights.isNotEmpty) ...[
              const SizedBox(height: AppSizes.md),
              Container(
                width: double.infinity,
                height: 1,
                color: widget.isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              const SizedBox(height: AppSizes.md),
              // Highlights
              ...widget.highlights.map(
                (highlight) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Text(
                          highlight,
                          style: AppTextStyles.bodySmall(secondaryColor),
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
    );
  }
}
