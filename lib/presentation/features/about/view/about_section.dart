import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/glass_card.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// About section widget displaying personal summary and highlights
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
        final profile = state.profile;

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
                  const SectionTitle(title: AppStrings.about),
                  const SizedBox(height: AppSizes.xl),
                  // Summary
                  Text(
                    profile.summary,
                    style: AppTextStyles.bodyLarge(secondaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  // Stats cards
                  Wrap(
                    spacing: AppSizes.lg,
                    runSpacing: AppSizes.lg,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatCard(
                        context,
                        AppStrings.yearsExperience,
                        AppStrings.yearsLabel,
                        Icons.work_outline_rounded,
                        textColor,
                        secondaryColor,
                        isDark,
                        isMobile,
                      ),
                      _buildStatCard(
                        context,
                        AppStrings.projectsCompleted,
                        AppStrings.projectsLabel,
                        Icons.rocket_launch_outlined,
                        textColor,
                        secondaryColor,
                        isDark,
                        isMobile,
                      ),
                      _buildStatCard(
                        context,
                        AppStrings.companiesWorked,
                        AppStrings.companiesLabel,
                        Icons.business_outlined,
                        textColor,
                        secondaryColor,
                        isDark,
                        isMobile,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xl),
                  // Key highlights
                  GlassCard(
                    padding: const EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Highlights',
                          style: AppTextStyles.titleMedium(textColor),
                        ),
                        const SizedBox(height: AppSizes.md),
                        _buildHighlightItem(
                          'Expert in Flutter & Dart with clean architecture patterns',
                          textColor,
                        ),
                        _buildHighlightItem(
                          'Proficient in Bloc, Provider, GetX, and Riverpod state management',
                          textColor,
                        ),
                        _buildHighlightItem(
                          'Experience with Firebase, REST APIs, and GraphQL integration',
                          textColor,
                        ),
                        _buildHighlightItem(
                          'Strong background in Domain Driven Design and Clean Architecture',
                          textColor,
                        ),
                        _buildHighlightItem(
                          'Published apps on Play Store and App Store with CI/CD pipelines',
                          textColor,
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

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color textColor,
    Color secondaryColor,
    bool isDark,
    bool isMobile,
  ) {
    return GlassCard(
      width: isMobile ? double.infinity : 180,
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppSizes.iconLg,
              color: AppColors.primaryOrange,
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            value,
            style: AppTextStyles.headlineMedium(textColor),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall(secondaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: const Icon(
              Icons.check_circle,
              size: AppSizes.iconSm,
              color: AppColors.primaryOrange,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium(textColor),
            ),
          ),
        ],
      ),
    );
  }
}
