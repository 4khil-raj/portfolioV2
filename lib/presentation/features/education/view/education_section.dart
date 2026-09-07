import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Ultra-Modern Education Section
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
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl * 2,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                children: [
                  ScrollFadeIn(
                    key: const ValueKey('education_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: AppStrings.education),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('education_subtitle'),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Academic foundation & engineering specialization',
                      style: AppTextStyles.bodyMedium(secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Education cards row / column
                  isMobile
                      ? Column(
                          children: education.asMap().entries.map((entry) {
                            final index = entry.key;
                            final edu = entry.value;
                            return ScrollSlideIn(
                              key: ValueKey('education_card_mobile_$index'),
                              direction: SlideDirection.bottom,
                              delay: Duration(milliseconds: 150 + (index * 150)),
                              child: Padding(
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
                                  index: index,
                                ),
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
                              child: ScrollReveal(
                                key: ValueKey('education_card_$index'),
                                delay: Duration(milliseconds: 150 + (index * 150)),
                                duration: const Duration(milliseconds: 800),
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
                                    index: index,
                                  ),
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
  final int index;

  const _EducationCard({
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    required this.index,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accentColors = [AppColors.primary, AppColors.secondary];
    final cardAccent = accentColors[widget.index % accentColors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? cardAccent.withValues(alpha: 0.45)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: cardAccent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Duration Pill Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: cardAccent,
                    size: 24,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: cardAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cardAccent.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    widget.duration,
                    style: AppTextStyles.labelSmall(cardAccent).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            // Degree Name
            Text(
              widget.degree,
              style: AppTextStyles.titleMedium(widget.textColor).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            // Institution Name
            Row(
              children: [
                Icon(
                  Icons.account_balance_rounded,
                  size: 14,
                  color: cardAccent,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.institution,
                    style: AppTextStyles.bodySmall(widget.secondaryColor).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.description != null) ...[
              const SizedBox(height: AppSizes.md),
              Text(
                widget.description!,
                style: AppTextStyles.bodySmall(widget.secondaryColor).copyWith(
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
