import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Ultra-Modern Contact Section with Direct Action Cards & Interactive Message Form
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
                    key: const ValueKey('contact_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: AppStrings.contact),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('contact_description'),
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 700),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 550),
                      child: Text(
                        AppStrings.contactDescription,
                        style: AppTextStyles.bodyMedium(secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Top Contact Quick Action Cards Grid
                  isMobile
                      ? Column(
                          children: [
                            _ContactActionCard(
                              icon: Icons.email_outlined,
                              title: 'Email Direct',
                              value: profile.email,
                              actionLabel: 'Send Email',
                              onTap: () => UrlLauncherUtil.sendEmail(
                                profile.email,
                                subject: 'Hello Akhil!',
                              ),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactActionCard(
                              icon: FontAwesomeIcons.whatsapp,
                              title: 'WhatsApp Quick Chat',
                              value: profile.phone,
                              actionLabel: 'Open Chat',
                              onTap: () => UrlLauncherUtil.openWhatsApp(
                                profile.phone,
                                message: 'Hi Akhil! I would like to discuss a Flutter project.',
                              ),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              accentColor: const Color(0xFF25D366),
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactActionCard(
                              icon: Icons.phone_outlined,
                              title: 'Phone Call',
                              value: profile.phone,
                              actionLabel: 'Call Now',
                              onTap: () => UrlLauncherUtil.makeCall(profile.phone),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactActionCard(
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              value: profile.location,
                              actionLabel: 'Kerala, India',
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              accentColor: AppColors.accentPink,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _ContactActionCard(
                                icon: Icons.email_outlined,
                                title: 'Email Direct',
                                value: profile.email,
                                actionLabel: 'Send Email',
                                onTap: () => UrlLauncherUtil.sendEmail(
                                  profile.email,
                                  subject: 'Hello Akhil!',
                                ),
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _ContactActionCard(
                                icon: FontAwesomeIcons.whatsapp,
                                title: 'WhatsApp Chat',
                                value: profile.phone,
                                actionLabel: 'Open Chat',
                                onTap: () => UrlLauncherUtil.openWhatsApp(
                                  profile.phone,
                                  message: 'Hi Akhil! I would like to discuss a Flutter project.',
                                ),
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                                accentColor: const Color(0xFF25D366),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _ContactActionCard(
                                icon: Icons.phone_outlined,
                                title: 'Phone Call',
                                value: profile.phone,
                                actionLabel: 'Call Now',
                                onTap: () => UrlLauncherUtil.makeCall(profile.phone),
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _ContactActionCard(
                                icon: Icons.location_on_outlined,
                                title: 'Location',
                                value: profile.location,
                                actionLabel: 'Kerala, India',
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                                accentColor: AppColors.accentPink,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: AppSizes.xxl * 1.5),
                  // Social networks bar
                  ScrollFadeIn(
                    key: const ValueKey('social_heading'),
                    delay: const Duration(milliseconds: 500),
                    child: Text(
                      'CONNECT ACROSS PLATFORMS',
                      style: AppTextStyles.labelSmall(secondaryColor).copyWith(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('social_buttons'),
                    delay: const Duration(milliseconds: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialPillButton(
                          icon: FontAwesomeIcons.github,
                          label: 'GitHub',
                          onTap: () => UrlLauncherUtil.openGitHub(profile.socialLinks.github),
                          isDark: isDark,
                        ),
                        const SizedBox(width: AppSizes.md),
                        _SocialPillButton(
                          icon: FontAwesomeIcons.linkedin,
                          label: 'LinkedIn',
                          onTap: () => UrlLauncherUtil.openLinkedIn(profile.socialLinks.linkedin),
                          isDark: isDark,
                        ),
                        const SizedBox(width: AppSizes.md),
                        _SocialPillButton(
                          icon: FontAwesomeIcons.code,
                          label: 'LeetCode',
                          onTap: () => UrlLauncherUtil.openLeetCode(profile.socialLinks.leetcode),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl * 1.5),
                  // Footer
                  Container(
                    padding: const EdgeInsets.only(top: AppSizes.xl),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Designed & Built with ',
                              style: AppTextStyles.bodySmall(secondaryColor),
                            ),
                            const Icon(
                              Icons.favorite_rounded,
                              size: 14,
                              color: AppColors.accentPink,
                            ),
                            Text(
                              ' using Flutter & Clean Architecture',
                              style: AppTextStyles.bodySmall(secondaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '© ${DateTime.now().year} Akhil Raj. All rights reserved.',
                          style: AppTextStyles.labelSmall(secondaryColor),
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

class _ContactActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String actionLabel;
  final VoidCallback? onTap;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final Color? accentColor;

  const _ContactActionCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.actionLabel,
    this.onTap,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    this.accentColor,
  });

  @override
  State<_ContactActionCard> createState() => _ContactActionCardState();
}

class _ContactActionCardState extends State<_ContactActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeAccent = widget.accentColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSizes.xl),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? activeAccent.withValues(alpha: 0.5)
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: activeAccent.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: activeAccent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: activeAccent,
                  size: 22,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Text(
                widget.title,
                style: AppTextStyles.labelMedium(widget.secondaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                style: AppTextStyles.bodyMedium(widget.textColor).copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.md),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.actionLabel,
                      style: AppTextStyles.labelSmall(activeAccent).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.onTap != null) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 12,
                        color: activeAccent,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _SocialPillButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialPillButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_SocialPillButton> createState() => _SocialPillButtonState();
}

class _SocialPillButtonState extends State<_SocialPillButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : (widget.isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? AppColors.primary
                    : (widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.labelSmall(
                  _isHovered
                      ? AppColors.primary
                      : (widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
