import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Next-Gen Experience Section with Glowing Vertical Timeline Rail
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
                    key: const ValueKey('experience_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: AppStrings.experience),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('experience_subtitle'),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Career journey & key engineering contributions',
                      style: AppTextStyles.bodyMedium(
                        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Timeline items
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final experience = experiences[index];
                      return ScrollSlideIn(
                        key: ValueKey('experience_item_$index'),
                        direction: index % 2 == 0 ? SlideDirection.left : SlideDirection.right,
                        delay: Duration(milliseconds: 150 + (index * 150)),
                        duration: const Duration(milliseconds: 800),
                        child: _TimelineExperienceCard(
                          experience: experience,
                          isLast: index == experiences.length - 1,
                          isDark: isDark,
                          index: index,
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

class _TimelineExperienceCard extends StatefulWidget {
  final dynamic experience;
  final bool isLast;
  final bool isDark;
  final int index;

  const _TimelineExperienceCard({
    required this.experience,
    required this.isLast,
    required this.isDark,
    required this.index,
  });

  @override
  State<_TimelineExperienceCard> createState() => _TimelineExperienceCardState();
}

class _TimelineExperienceCardState extends State<_TimelineExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;

    final accentColors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
    ];
    final cardAccent = accentColors[widget.index % accentColors.length];

    final nodeSize = widget.experience.isCurrent ? 22.0 : 18.0;
    final dotCenterLeft = nodeSize / 2 - 1.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.xxl),
      child: Stack(
        children: [
          // Connecting Timeline Rail Line
          if (!widget.isLast)
            Positioned(
              left: dotCenterLeft,
              top: nodeSize,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cardAccent.withValues(alpha: 0.6),
                      accentColors[(widget.index + 1) % accentColors.length].withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Step Node Dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: nodeSize,
                height: nodeSize,
                decoration: BoxDecoration(
                  color: widget.experience.isCurrent
                      ? cardAccent
                      : (widget.isDark ? AppColors.darkCard : AppColors.lightCard),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cardAccent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cardAccent.withValues(alpha: widget.experience.isCurrent ? 0.6 : 0.3),
                      blurRadius: widget.experience.isCurrent ? 12 : 6,
                      spreadRadius: widget.experience.isCurrent ? 2 : 0,
                    ),
                  ],
                ),
                child: widget.experience.isCurrent
                    ? const Center(
                        child: Icon(Icons.check, size: 10, color: Colors.white),
                      )
                    : null,
              ),
              SizedBox(width: isMobile ? AppSizes.md : AppSizes.lg),
              // Main Experience Details Card
              Expanded(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isMobile ? AppSizes.lg : AppSizes.xl),
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
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: widget.isDark ? 0.2 : 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header Row: Role Title & Current Badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: cardAccent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(Icons.work_rounded, color: cardAccent, size: 22),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: [
                                      Text(
                                        widget.experience.role,
                                        style: AppTextStyles.titleMedium(textColor).copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (widget.experience.isCurrent)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.accent.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 6,
                                                height: 6,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.accent,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Present Role',
                                                style: AppTextStyles.labelSmall(AppColors.accent).copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.experience.company,
                                    style: AppTextStyles.bodyMedium(cardAccent).copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.md),
                        // Duration & Location Meta Bar
                        Wrap(
                          spacing: AppSizes.lg,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today_rounded, size: 14, color: secondaryColor),
                                const SizedBox(width: 6),
                                Text(
                                  widget.experience.duration,
                                  style: AppTextStyles.bodySmall(secondaryColor).copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on_rounded, size: 14, color: secondaryColor),
                                const SizedBox(width: 6),
                                Text(
                                  widget.experience.location,
                                  style: AppTextStyles.bodySmall(secondaryColor).copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.md),
                        const Divider(height: 1),
                        const SizedBox(height: AppSizes.md),
                        // Highlights Bullet Points
                        ...(widget.experience.highlights as List<String>).map((highlight) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.arrow_right_rounded, size: 18, color: cardAccent),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: AppTextStyles.bodySmall(secondaryColor).copyWith(height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
