import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../../../common/widgets/animated_gradient_button.dart';
import '../../../../common/widgets/social_icon_button.dart';
import '../../view_model/home_cubit.dart';

/// Hero section widget displaying profile image, introduction, and call-to-action buttons
class HeroSection extends StatelessWidget {
  final VoidCallback onContactPressed;

  const HeroSection({
    super.key,
    required this.onContactPressed,
  });

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
            vertical: isMobile ? AppSizes.xl : AppSizes.xxxl,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      AppColors.darkBackground,
                      AppColors.darkSurface.withValues(alpha: 0.5),
                      AppColors.darkBackground,
                    ]
                  : [
                      AppColors.lightBackground,
                      AppColors.lightSurface,
                      AppColors.lightBackground,
                    ],
            ),
          ),
          child: Stack(
            children: [
              // Decorative gradient blobs
              Positioned(
                top: -150,
                right: -100,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryBlue.withValues(alpha: 0.15),
                        AppColors.primaryBlue.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryPurple.withValues(alpha: 0.1),
                        AppColors.primaryPurple.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                right: 50,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryCyan.withValues(alpha: 0.1),
                        AppColors.primaryCyan.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Image with gradient border
                      _buildProfileImage(isDark, isMobile),
                      const SizedBox(height: AppSizes.xl),
                      // Greeting
                      Text(
                        '${AppStrings.heroGreeting} ${AppStrings.heroWave}',
                        style: AppTextStyles.titleLarge(secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      // Name
                      Text(
                        profile.name,
                        style: isMobile
                            ? AppTextStyles.displaySmall(textColor)
                            : AppTextStyles.heroTitle(textColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.md),
                      // Title with gradient
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientMiddle,
                            AppColors.gradientEnd,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          profile.title,
                          style: isMobile
                              ? AppTextStyles.headlineMedium(Colors.white)
                              : AppTextStyles.headlineLarge(Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      // Summary
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          profile.summary,
                          style: AppTextStyles.bodyLarge(secondaryColor),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppSizes.xl),
                      // CTA Buttons
                      Wrap(
                        spacing: AppSizes.md,
                        runSpacing: AppSizes.md,
                        alignment: WrapAlignment.center,
                        children: [
                          AnimatedGradientButton(
                            text: AppStrings.downloadCv,
                            icon: Icons.download_rounded,
                            onPressed: () {
                              UrlLauncherUtil.launchURL(AppStrings.cvUrl);
                            },
                          ),
                          AnimatedGradientButton(
                            text: AppStrings.contactMe,
                            icon: Icons.mail_outline_rounded,
                            isPrimary: false,
                            onPressed: onContactPressed,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.xl),
                      // Social icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialIconButton(
                            icon: FontAwesomeIcons.github,
                            tooltip: AppStrings.github,
                            onPressed: () {
                              UrlLauncherUtil.openGitHub(
                                  profile.socialLinks.github);
                            },
                          ),
                          const SizedBox(width: AppSizes.md),
                          SocialIconButton(
                            icon: FontAwesomeIcons.linkedin,
                            tooltip: AppStrings.linkedin,
                            onPressed: () {
                              UrlLauncherUtil.openLinkedIn(
                                  profile.socialLinks.linkedin);
                            },
                          ),
                          const SizedBox(width: AppSizes.md),
                          SocialIconButton(
                            icon: FontAwesomeIcons.code,
                            tooltip: AppStrings.leetcode,
                            onPressed: () {
                              UrlLauncherUtil.openLeetCode(
                                  profile.socialLinks.leetcode);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the profile image with animated gradient border
  Widget _buildProfileImage(bool isDark, bool isMobile) {
    final imageSize = isMobile ? 140.0 : 180.0;
    final borderWidth = isMobile ? 4.0 : 5.0;

    return Container(
      width: imageSize + borderWidth * 2,
      height: imageSize + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.jpg',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to initials if image not found
              return Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.gradientStart.withValues(alpha: 0.2),
                      AppColors.gradientEnd.withValues(alpha: 0.2),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'AR',
                    style: AppTextStyles.displaySmall(
                      isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
