import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/glass_card.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Education section widget displaying academic history
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
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(alpha: 0.3)
                : AppColors.lightBackground,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.education),
                  const SizedBox(height: AppSizes.xl),
                  // Education cards
                  Wrap(
                    spacing: AppSizes.lg,
                    runSpacing: AppSizes.lg,
                    alignment: WrapAlignment.center,
                    children: education.map((edu) {
                      return SizedBox(
                        width: isMobile
                            ? double.infinity
                            : (screenWidth < AppSizes.desktopBreakpoint
                                ? screenWidth * 0.4
                                : 400),
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSizes.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(AppSizes.md),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primaryOrange.withValues(alpha: 0.1),
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.radiusMd),
                                    ),
                                    child: const Icon(
                                      Icons.school_outlined,
                                      size: AppSizes.iconLg,
                                      color: AppColors.primaryOrange,
                                    ),
                                  ),
                                  const SizedBox(width: AppSizes.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          edu.degree,
                                          style: AppTextStyles.cardTitle(textColor),
                                        ),
                                        const SizedBox(height: AppSizes.xs),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSizes.sm,
                                            vertical: AppSizes.xs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryOrange
                                                .withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.radiusFull),
                                          ),
                                          child: Text(
                                            edu.duration,
                                            style: AppTextStyles.labelSmall(
                                                AppColors.primaryOrange),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSizes.md),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: AppSizes.iconSm,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(width: AppSizes.xs),
                                  Expanded(
                                    child: Text(
                                      edu.institution,
                                      style: AppTextStyles.bodySmall(secondaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              if (edu.description != null) ...[
                                const SizedBox(height: AppSizes.sm),
                                Text(
                                  edu.description!,
                                  style: AppTextStyles.bodySmall(secondaryColor),
                                ),
                              ],
                            ],
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
