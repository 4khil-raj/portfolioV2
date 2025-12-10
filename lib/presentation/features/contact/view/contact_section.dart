import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Clean, minimal Contact section
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
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.contact),
                  const SizedBox(height: AppSizes.md),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      AppStrings.contactDescription,
                      style: AppTextStyles.bodyMedium(secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Contact cards
                  isMobile
                      ? Column(
                          children: [
                            _ContactCard(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: profile.email,
                              onTap: () => UrlLauncherUtil.sendEmail(
                                profile.email,
                                subject: 'Hello Akhil!',
                              ),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactCard(
                              icon: Icons.phone_outlined,
                              title: 'Phone',
                              value: profile.phone,
                              onTap: () => UrlLauncherUtil.makeCall(profile.phone),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactCard(
                              icon: FontAwesomeIcons.whatsapp,
                              title: 'WhatsApp',
                              value: profile.phone,
                              onTap: () => UrlLauncherUtil.openWhatsApp(
                                profile.phone,
                                message: 'Hi Akhil! I found your portfolio.',
                              ),
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              iconColor: const Color(0xFF25D366),
                            ),
                            const SizedBox(height: AppSizes.md),
                            _ContactCard(
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              value: profile.location,
                              isDark: isDark,
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                              showContactButton: true,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _ContactCard(
                                icon: Icons.email_outlined,
                                title: 'Email',
                                value: profile.email,
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
                              child: _ContactCard(
                                icon: Icons.phone_outlined,
                                title: 'Phone',
                                value: profile.phone,
                                onTap: () => UrlLauncherUtil.makeCall(profile.phone),
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _ContactCard(
                                icon: FontAwesomeIcons.whatsapp,
                                title: 'WhatsApp',
                                value: profile.phone,
                                onTap: () => UrlLauncherUtil.openWhatsApp(
                                  profile.phone,
                                  message: 'Hi Akhil! I found your portfolio.',
                                ),
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                                iconColor: const Color(0xFF25D366),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: _ContactCard(
                                icon: Icons.location_on_outlined,
                                title: 'Location',
                                value: profile.location,
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                                showContactButton: true,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: AppSizes.xxl),
                  // Social links
                  Text(
                    'Connect with me',
                    style: AppTextStyles.labelMedium(secondaryColor),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(
                        icon: FontAwesomeIcons.github,
                        onTap: () =>
                            UrlLauncherUtil.openGitHub(profile.socialLinks.github),
                        isDark: isDark,
                      ),
                      const SizedBox(width: AppSizes.md),
                      _SocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        onTap: () =>
                            UrlLauncherUtil.openLinkedIn(profile.socialLinks.linkedin),
                        isDark: isDark,
                      ),
                      const SizedBox(width: AppSizes.md),
                      _SocialButton(
                        icon: FontAwesomeIcons.code,
                        onTap: () =>
                            UrlLauncherUtil.openLeetCode(profile.socialLinks.leetcode),
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Footer
                  Container(
                    padding: const EdgeInsets.only(top: AppSizes.lg),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Made with ',
                              style: AppTextStyles.bodySmall(secondaryColor),
                            ),
                            const Icon(
                              Icons.favorite,
                              size: 14,
                              color: AppColors.accentPink,
                            ),
                            Text(
                              ' using Flutter',
                              style: AppTextStyles.bodySmall(secondaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          '© ${DateTime.now().year} Akhil Raj',
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

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final Color? iconColor;
  final bool showContactButton;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    this.iconColor,
    this.showContactButton = false,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
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
          padding: const EdgeInsets.all(AppSizes.xl),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: (widget.iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor ?? AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Text(
                widget.title,
                style: AppTextStyles.labelMedium(widget.secondaryColor),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                widget.value,
                style: AppTextStyles.bodyMedium(widget.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.md),
              if (widget.onTap != null || widget.showContactButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact',
                      style: AppTextStyles.labelSmall(AppColors.primary),
                    ),
                    const SizedBox(width: AppSizes.xs),
                    const Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: AppColors.primary,
                    ),
                  ],
                )
              else
                const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : (widget.isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            ),
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              size: 18,
              color: _isHovered
                  ? AppColors.primary
                  : (widget.isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
