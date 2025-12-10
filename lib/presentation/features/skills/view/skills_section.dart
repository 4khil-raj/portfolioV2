import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Modern 2025 Skills section with clean design
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final isTablet = screenWidth < AppSizes.tabletBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final skillCategories = state.skillCategories;
        final mainSkills = state.mainSkills;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl * 2,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.skills),
                  const SizedBox(height: AppSizes.xxl),
                  // Main skills progress bars
                  Container(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.secondary],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.analytics_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Text(
                              'Core Skills',
                              style: AppTextStyles.titleMedium(textColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.xl),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 2),
                            crossAxisSpacing: AppSizes.xxl,
                            mainAxisSpacing: AppSizes.lg,
                            mainAxisExtent: 65,
                          ),
                          itemCount: mainSkills.length,
                          itemBuilder: (context, index) {
                            final skill = mainSkills[index];
                            return _SkillProgressBar(
                              name: skill.name,
                              proficiency: skill.proficiency.toDouble(),
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              isDark: isDark,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Tech stack categories
                  Container(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.secondary, AppColors.accent],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.layers_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Text(
                              'Tech Stack',
                              style: AppTextStyles.titleMedium(textColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.xl),
                        Wrap(
                          spacing: AppSizes.md,
                          runSpacing: AppSizes.md,
                          children: skillCategories.map((category) {
                            return _SkillCategoryCard(
                              category: category.category,
                              skills: category.skills,
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              colorIndex: category.colorIndex,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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

class _SkillProgressBar extends StatelessWidget {
  final String name;
  final double proficiency;
  final Color textColor;
  final Color secondaryColor;
  final bool isDark;

  const _SkillProgressBar({
    required this.name,
    required this.proficiency,
    required this.textColor,
    required this.secondaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (proficiency * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppTextStyles.bodyMedium(textColor).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$percentage%',
                style: AppTextStyles.labelSmall(AppColors.primary).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkDivider
                : AppColors.lightDivider,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: proficiency,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Skill category card showing category and all skills directly
class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final List<String> skills;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final int colorIndex;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    required this.colorIndex,
  });

  Color get _categoryColor {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      AppColors.accentPink,
      AppColors.accentWarm,
      AppColors.info,
      AppColors.success,
      AppColors.warning,
    ];
    return colors[colorIndex % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _categoryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Text(
                category,
                style: AppTextStyles.labelMedium(textColor).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Wrap(
            spacing: AppSizes.xs,
            runSpacing: AppSizes.xs,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _categoryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  skill,
                  style: AppTextStyles.labelSmall(_categoryColor).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
