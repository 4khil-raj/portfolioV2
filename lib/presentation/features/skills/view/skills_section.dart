import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/chip_list.dart';
import '../../../common/widgets/glass_card.dart';
import '../../../common/widgets/section_title.dart';
import '../../../common/widgets/skill_meter.dart';
import '../../home/view_model/home_cubit.dart';

/// Skills section widget displaying skill categories and proficiency meters
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
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
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.skills),
                  const SizedBox(height: AppSizes.xl),
                  // Main skills with progress meters
                  GlassCard(
                    padding: const EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Core Competencies',
                          style: AppTextStyles.titleMedium(textColor),
                        ),
                        const SizedBox(height: AppSizes.lg),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                            crossAxisSpacing: AppSizes.xl,
                            mainAxisSpacing: AppSizes.lg,
                            mainAxisExtent: 60,
                          ),
                          itemCount: mainSkills.length,
                          itemBuilder: (context, index) {
                            final skill = mainSkills[index];
                            return SkillMeter(
                              skillName: skill.name,
                              proficiency: skill.proficiency,
                              color: AppColors.skillColors[
                                  index % AppColors.skillColors.length],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.xl),
                  // Skill categories grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
                      crossAxisSpacing: AppSizes.md,
                      mainAxisSpacing: AppSizes.md,
                      mainAxisExtent: isMobile ? null : 180,
                      childAspectRatio: isMobile ? 2.5 : 1,
                    ),
                    itemCount: skillCategories.length,
                    itemBuilder: (context, index) {
                      final category = skillCategories[index];
                      final color = AppColors.skillColors[
                          category.colorIndex % AppColors.skillColors.length];

                      return GlassCard(
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.radiusFull),
                                  ),
                                ),
                                const SizedBox(width: AppSizes.sm),
                                Expanded(
                                  child: Text(
                                    category.category,
                                    style: AppTextStyles.labelLarge(textColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.md),
                            Expanded(
                              child: ChipList(
                                items: category.skills,
                                chipColor: color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
