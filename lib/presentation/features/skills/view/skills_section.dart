import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Ultra-Modern Skills & Tech Stack Section
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
                  ScrollFadeIn(
                    key: const ValueKey('skills_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: AppStrings.skills),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('skills_subtitle'),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Technical competencies & framework proficiencies',
                      style: AppTextStyles.bodyMedium(secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Core Proficiency Progress Bars Container
                  ScrollReveal(
                    key: const ValueKey('core_skills_card'),
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.xl),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.lightCard,
                        borderRadius: BorderRadius.circular(24),
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
                                    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.speed_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              Text(
                                'Core Mastery Levels',
                                style: AppTextStyles.titleMedium(textColor).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.xl),
                          AnimationLimiter(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 2),
                                crossAxisSpacing: AppSizes.xxl,
                                mainAxisSpacing: AppSizes.lg,
                                mainAxisExtent: 70,
                              ),
                              itemCount: mainSkills.length,
                              itemBuilder: (context, index) {
                                final skill = mainSkills[index];
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  columnCount: isMobile ? 1 : (isTablet ? 2 : 2),
                                  duration: const Duration(milliseconds: 600),
                                  child: FadeInAnimation(
                                    child: SlideAnimation(
                                      verticalOffset: 25,
                                      child: _SkillProgressBar(
                                        name: skill.name,
                                        proficiency: skill.proficiency.toDouble(),
                                        textColor: textColor,
                                        secondaryColor: secondaryColor,
                                        isDark: isDark,
                                        index: index,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Tech Stack Categories Container
                  ScrollReveal(
                    key: const ValueKey('tech_stack_card'),
                    delay: const Duration(milliseconds: 350),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.xl),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.lightCard,
                        borderRadius: BorderRadius.circular(24),
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
                                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.layers_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              Text(
                                'Full Tech Ecosystem',
                                style: AppTextStyles.titleMedium(textColor).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.xl),
                          AnimationLimiter(
                            child: Wrap(
                              spacing: AppSizes.md,
                              runSpacing: AppSizes.md,
                              children: List.generate(
                                skillCategories.length,
                                (index) {
                                  final category = skillCategories[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: FadeInAnimation(
                                      child: ScaleAnimation(
                                        scale: 0.85,
                                        child: _SkillCategoryCard(
                                          category: category.category,
                                          skills: category.skills,
                                          isDark: isDark,
                                          textColor: textColor,
                                          secondaryColor: secondaryColor,
                                          colorIndex: category.colorIndex,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
  final int index;

  const _SkillProgressBar({
    required this.name,
    required this.proficiency,
    required this.textColor,
    required this.secondaryColor,
    required this.isDark,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (proficiency * 100).toInt();

    final gradients = [
      const [Color(0xFF06B6D4), Color(0xFF38BDF8)],
      const [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
      const [Color(0xFF10B981), Color(0xFF34D399)],
      const [Color(0xFFEC4899), Color(0xFFF472B6)],
    ];

    final colors = gradients[index % gradients.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppTextStyles.bodyMedium(textColor).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: colors[0].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colors[0].withValues(alpha: 0.3)),
              ),
              child: Text(
                '$percentage%',
                style: AppTextStyles.labelSmall(colors[0]).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightDivider,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: proficiency,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                boxShadow: [
                  BoxShadow(
                    color: colors[0].withValues(alpha: 0.4),
                    blurRadius: 8,
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

class _SkillCategoryCard extends StatefulWidget {
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

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  Color get _categoryColor {
    const colors = AppColors.skillColors;
    return colors[widget.colorIndex % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.md + 2),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered
                ? _categoryColor.withValues(alpha: 0.45)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: _categoryColor.withValues(alpha: 0.12),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _categoryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Text(
                  widget.category,
                  style: AppTextStyles.labelMedium(widget.textColor).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _categoryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    skill,
                    style: AppTextStyles.labelSmall(_categoryColor).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
