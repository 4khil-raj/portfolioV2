import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../../common/widgets/animated_gradient_button.dart';
import '../../../common/widgets/glass_card.dart';
import '../../../common/widgets/section_title.dart';
import '../../../common/widgets/social_icon_button.dart';
import '../../home/view_model/home_cubit.dart';

/// Contact section widget with email, phone, and social links
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
                  const SectionTitle(title: AppStrings.contact),
                  const SizedBox(height: AppSizes.lg),
                  Text(
                    AppStrings.letsConnect,
                    style: AppTextStyles.headlineSmall(textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      AppStrings.contactDescription,
                      style: AppTextStyles.bodyMedium(secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xl),
                  // Contact cards
                  Wrap(
                    spacing: AppSizes.lg,
                    runSpacing: AppSizes.lg,
                    alignment: WrapAlignment.center,
                    children: [
                      // Email card
                      SizedBox(
                        width: isMobile ? double.infinity : 300,
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSizes.lg),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppSizes.md),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryOrange.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.email_outlined,
                                  size: AppSizes.iconLg,
                                  color: AppColors.primaryOrange,
                                ),
                              ),
                              const SizedBox(height: AppSizes.md),
                              Text(
                                'Email',
                                style: AppTextStyles.titleSmall(secondaryColor),
                              ),
                              const SizedBox(height: AppSizes.xs),
                              Text(
                                profile.email,
                                style: AppTextStyles.bodyMedium(textColor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppSizes.md),
                              AnimatedGradientButton(
                                text: AppStrings.emailMe,
                                icon: Icons.send_rounded,
                                onPressed: () {
                                  UrlLauncherUtil.sendEmail(
                                    profile.email,
                                    subject: 'Hello Akhil!',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Phone card
                      SizedBox(
                        width: isMobile ? double.infinity : 300,
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSizes.lg),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppSizes.md),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryTeal.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.phone_outlined,
                                  size: AppSizes.iconLg,
                                  color: AppColors.primaryTeal,
                                ),
                              ),
                              const SizedBox(height: AppSizes.md),
                              Text(
                                'Phone',
                                style: AppTextStyles.titleSmall(secondaryColor),
                              ),
                              const SizedBox(height: AppSizes.xs),
                              Text(
                                profile.phone,
                                style: AppTextStyles.bodyMedium(textColor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppSizes.md),
                              AnimatedGradientButton(
                                text: AppStrings.callMe,
                                icon: Icons.call_rounded,
                                isPrimary: false,
                                onPressed: () {
                                  UrlLauncherUtil.makeCall(profile.phone);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Location card
                      SizedBox(
                        width: isMobile ? double.infinity : 300,
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSizes.lg),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppSizes.md),
                                decoration: BoxDecoration(
                                  color: AppColors.info.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  size: AppSizes.iconLg,
                                  color: AppColors.info,
                                ),
                              ),
                              const SizedBox(height: AppSizes.md),
                              Text(
                                'Location',
                                style: AppTextStyles.titleSmall(secondaryColor),
                              ),
                              const SizedBox(height: AppSizes.xs),
                              Text(
                                profile.location,
                                style: AppTextStyles.bodyMedium(textColor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppSizes.md),
                              Text(
                                'Available for Remote Work',
                                style: AppTextStyles.labelSmall(AppColors.success),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xl),
                  // Social links
                  Text(
                    'Connect with me',
                    style: AppTextStyles.titleSmall(secondaryColor),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIconButton(
                        icon: FontAwesomeIcons.github,
                        tooltip: AppStrings.github,
                        onPressed: () {
                          UrlLauncherUtil.openGitHub(profile.socialLinks.github);
                        },
                      ),
                      const SizedBox(width: AppSizes.md),
                      SocialIconButton(
                        icon: FontAwesomeIcons.linkedin,
                        tooltip: AppStrings.linkedin,
                        onPressed: () {
                          UrlLauncherUtil.openLinkedIn(profile.socialLinks.linkedin);
                        },
                      ),
                      const SizedBox(width: AppSizes.md),
                      SocialIconButton(
                        icon: FontAwesomeIcons.code,
                        tooltip: AppStrings.leetcode,
                        onPressed: () {
                          UrlLauncherUtil.openLeetCode(profile.socialLinks.leetcode);
                        },
                      ),
                    ],
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
