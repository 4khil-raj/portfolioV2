import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../view_model/home_cubit.dart';

/// Modern 2025 Hero section with full image display
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
    final isTablet = screenWidth < AppSizes.tabletBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final profile = state.profile;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isMobile ? 600 : 700,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSizes.lg : AppSizes.xxl * 2,
                vertical: isMobile ? AppSizes.xl : AppSizes.xxl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: isMobile || isTablet
                      ? _buildMobileLayout(context, profile, isDark, textColor, secondaryColor, isMobile)
                      : _buildDesktopLayout(context, profile, isDark, textColor, secondaryColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    dynamic profile,
    bool isDark,
    Color textColor,
    Color secondaryColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: _buildTextContent(context, profile, isDark, textColor, secondaryColor, false),
        ),
        const SizedBox(width: AppSizes.xxl * 2),
        Expanded(
          flex: 4,
          child: _buildProfileImage(isDark, false),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    dynamic profile,
    bool isDark,
    Color textColor,
    Color secondaryColor,
    bool isMobile,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(isDark, true),
        const SizedBox(height: AppSizes.xxl),
        _buildTextContent(context, profile, isDark, textColor, secondaryColor, true),
      ],
    );
  }

  Widget _buildTextContent(
    BuildContext context,
    dynamic profile,
    bool isDark,
    Color textColor,
    Color secondaryColor,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for work',
                style: AppTextStyles.labelSmall(AppColors.accent),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        // Name with gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            profile.name,
            style: isMobile
                ? AppTextStyles.displaySmall(Colors.white)
                : AppTextStyles.displayLarge(Colors.white),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        // Title
        Text(
          profile.title,
          style: isMobile
              ? AppTextStyles.titleLarge(secondaryColor)
              : AppTextStyles.headlineSmall(secondaryColor),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: AppSizes.lg),
        // Summary
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 520),
          child: Text(
            profile.heroSummary,
            style: AppTextStyles.bodyLarge(secondaryColor).copyWith(height: 1.7),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: AppSizes.xl),
        // CTA Buttons
        Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.md,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryButton(
              text: AppStrings.contactMe,
              onPressed: onContactPressed,
            ),
            _OutlineButton(
              text: AppStrings.downloadCv,
              icon: Icons.download_rounded,
              onPressed: () => UrlLauncherUtil.downloadCV(AppStrings.cvUrl),
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.xxl),
        // Social links
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              'Find me on',
              style: AppTextStyles.labelSmall(secondaryColor),
            ),
            const SizedBox(width: AppSizes.md),
            _SocialIcon(
              icon: FontAwesomeIcons.github,
              onPressed: () => UrlLauncherUtil.openGitHub(profile.socialLinks.github),
              isDark: isDark,
            ),
            const SizedBox(width: AppSizes.sm),
            _SocialIcon(
              icon: FontAwesomeIcons.linkedin,
              onPressed: () => UrlLauncherUtil.openLinkedIn(profile.socialLinks.linkedin),
              isDark: isDark,
            ),
            const SizedBox(width: AppSizes.sm),
            _SocialIcon(
              icon: FontAwesomeIcons.code,
              onPressed: () => UrlLauncherUtil.openLeetCode(profile.socialLinks.leetcode),
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark, bool isMobile) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile ? 280 : 420,
        maxHeight: isMobile ? 320 : 480,
      ),
      child: Stack(
        children: [
          // Background decorative shape
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: isMobile ? 240 : 360,
              height: isMobile ? 280 : 420,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.secondary.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(isMobile ? 20 : 30),
              ),
            ),
          ),
          // Main image
          Positioned(
            left: isMobile ? 20 : 30,
            top: isMobile ? 20 : 30,
            child: Container(
              width: isMobile ? 240 : 360,
              height: isMobile ? 280 : 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: isMobile ? 240 : 360,
                  height: isMobile ? 280 : 420,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: isMobile ? 240 : 360,
                      height: isMobile ? 280 : 420,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.2),
                            AppColors.secondary.withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/download.png',
                          width: isMobile ? 100 : 150,
                          height: isMobile ? 100 : 150,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Primary CTA button with gradient
class _PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [AppColors.primaryDark, AppColors.primary]
                  : [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: AppTextStyles.button(Colors.white),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Outline button
class _OutlineButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _OutlineButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.darkText : AppColors.lightText;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isDark ? AppColors.darkSurface : AppColors.lightDivider)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: _isHovered ? AppColors.primary : textColor,
              ),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: AppTextStyles.button(
                  _isHovered ? AppColors.primary : textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Social icon button
class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _SocialIcon({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            ),
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              size: 16,
              color: _isHovered
                  ? AppColors.primary
                  : (widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
