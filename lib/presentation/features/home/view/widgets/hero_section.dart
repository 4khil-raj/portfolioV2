import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../../../../core/utils/scroll_animations.dart';
import '../../view_model/home_cubit.dart';

/// Ultra-Modern 2025/2026 Hero Section with Neon Glow Avatar and Floating Stats
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
            minHeight: isMobile ? 650 : 750,
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
                  constraints: const BoxConstraints(maxWidth: 1350),
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
          flex: 6,
          child: ScrollFadeIn(
            key: const ValueKey('hero_text_content'),
            offset: const Offset(-40, 0),
            duration: const Duration(milliseconds: 800),
            child: _buildTextContent(context, profile, isDark, textColor, secondaryColor, false),
          ),
        ),
        const SizedBox(width: AppSizes.xxl),
        Expanded(
          flex: 5,
          child: ScrollReveal(
            key: const ValueKey('hero_profile_image'),
            duration: const Duration(milliseconds: 900),
            delay: const Duration(milliseconds: 150),
            child: _buildProfileImage(isDark, false),
          ),
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
        ScrollReveal(
          key: const ValueKey('hero_mobile_image'),
          duration: const Duration(milliseconds: 900),
          child: _buildProfileImage(isDark, true),
        ),
        const SizedBox(height: AppSizes.xxl),
        ScrollFadeIn(
          key: const ValueKey('hero_mobile_text'),
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 800),
          child: _buildTextContent(context, profile, isDark, textColor, secondaryColor, true),
        ),
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
    return StaggeredList(
      staggerDelay: const Duration(milliseconds: 120),
      itemDuration: const Duration(milliseconds: 700),
      children: [
        // Live Pulsing Availability Badge
        Container(
          alignment: isMobile ? Alignment.center : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulsingDot(),
                const SizedBox(width: 10),
                Text(
                  'Available for Senior Flutter Roles & Projects',
                  style: AppTextStyles.labelSmall(AppColors.accent).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        // Gradient Shimmer Header
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ).createShader(bounds),
          child: Text(
            profile.name,
            style: isMobile
                ? AppTextStyles.displaySmall(Colors.white).copyWith(fontSize: 40, fontWeight: FontWeight.w800)
                : AppTextStyles.displayLarge(Colors.white).copyWith(fontSize: 64, fontWeight: FontWeight.w800),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        // Title & Role
        Text(
          profile.title,
          style: isMobile
              ? AppTextStyles.titleLarge(secondaryColor).copyWith(fontWeight: FontWeight.w600)
              : AppTextStyles.headlineSmall(secondaryColor).copyWith(fontWeight: FontWeight.w600),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: AppSizes.lg),
        // Hero summary
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 560),
          child: Text(
            profile.heroSummary,
            style: AppTextStyles.bodyLarge(secondaryColor).copyWith(
              height: 1.7,
              fontSize: isMobile ? 15 : 17,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: AppSizes.xl),
        // Tech stack pill highlights
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: ['Flutter', 'Dart', 'Bloc', 'Clean Arch', 'AI-Assisted Dev', 'Firebase', 'REST APIs'].map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
              ),
              child: Text(
                '# $tag',
                style: AppTextStyles.labelSmall(AppColors.primary).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSizes.xxl),
        // CTA Action Buttons
        Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.md,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryGradientButton(
              text: AppStrings.contactMe,
              onPressed: onContactPressed,
            ),
            _GlassOutlineButton(
              text: AppStrings.downloadCv,
              icon: Icons.download_rounded,
              onPressed: () => UrlLauncherUtil.downloadCV(AppStrings.cvUrl),
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.xxl),
        // Social links bar
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              'Connect',
              style: AppTextStyles.labelSmall(secondaryColor).copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: AppSizes.md),
            _SocialIconPill(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              onPressed: () => UrlLauncherUtil.openGitHub(profile.socialLinks.github),
              isDark: isDark,
            ),
            const SizedBox(width: AppSizes.sm),
            _SocialIconPill(
              icon: FontAwesomeIcons.linkedin,
              label: 'LinkedIn',
              onPressed: () => UrlLauncherUtil.openLinkedIn(profile.socialLinks.linkedin),
              isDark: isDark,
            ),
            const SizedBox(width: AppSizes.sm),
            _SocialIconPill(
              icon: FontAwesomeIcons.code,
              label: 'LeetCode',
              onPressed: () => UrlLauncherUtil.openLeetCode(profile.socialLinks.leetcode),
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark, bool isMobile) {
    return _FloatingWidget(
      child: Center(
        child: SizedBox(
          width: isMobile ? 300 : 420,
          height: isMobile ? 360 : 490,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Ambient Neon Glowing Backdrop Spheres
              Positioned(
                top: -10,
                left: -10,
                child: Container(
                  width: isMobile ? 180 : 250,
                  height: isMobile ? 180 : 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x6606B6D4), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: Container(
                  width: isMobile ? 180 : 250,
                  height: isMobile ? 180 : 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x668B5CF6), Colors.transparent],
                    ),
                  ),
                ),
              ),
              // Main Image Frame with Glowing Border
              Container(
                width: isMobile ? 240 : 340,
                height: isMobile ? 290 : 410,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 35,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3.5),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          child: const Icon(Icons.person, size: 80, color: AppColors.primary),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Floating Badge 1: Experience (Top Right)
              Positioned(
                top: isMobile ? 10 : 20,
                right: isMobile ? 0 : -15,
                child: _FloatingBadge(
                  icon: Icons.electric_bolt_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  title: '3+ Yrs',
                  subtitle: 'Flutter Exp',
                  isDark: isDark,
                ),
              ),
              // Floating Badge 2: Architecture (Bottom Left)
              Positioned(
                bottom: isMobile ? 10 : 30,
                left: isMobile ? 0 : -20,
                child: _FloatingBadge(
                  icon: Icons.verified_user_rounded,
                  iconColor: AppColors.primary,
                  title: 'DDD & Bloc',
                  subtitle: 'Clean Architect',
                  isDark: isDark,
                ),
              ),
              // Floating Badge 3: AI Development (Bottom Right)
              Positioned(
                bottom: isMobile ? -15 : -10,
                right: isMobile ? 10 : 20,
                child: _FloatingBadge(
                  icon: Icons.auto_awesome_rounded,
                  iconColor: const Color(0xFFEC4899),
                  title: 'AI-Assisted',
                  subtitle: 'Development',
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 9,
        height: 9,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isDark;

  const _FloatingBadge({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard.withValues(alpha: 0.92)
            : AppColors.lightCard.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.labelMedium(
                  isDark ? AppColors.darkText : AppColors.lightText,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: AppTextStyles.labelSmall(
                  isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrimaryGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryGradientButton({
    required this.text,
    required this.onPressed,
  });

  @override
  State<_PrimaryGradientButton> createState() => _PrimaryGradientButtonState();
}

class _PrimaryGradientButtonState extends State<_PrimaryGradientButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF06B6D4).withValues(alpha: _isHovered ? 0.5 : 0.3),
                blurRadius: _isHovered ? 20 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: AppTextStyles.button(Colors.white).copyWith(
                  fontWeight: FontWeight.bold,
                ),
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

class _GlassOutlineButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _GlassOutlineButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<_GlassOutlineButton> createState() => _GlassOutlineButtonState();
}

class _GlassOutlineButtonState extends State<_GlassOutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
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
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconPill extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isDark;

  const _SocialIconPill({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isDark,
  });

  @override
  State<_SocialIconPill> createState() => _SocialIconPillState();
}

class _SocialIconPillState extends State<_SocialIconPill> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.12)
                : (widget.isDark ? AppColors.darkSurface : AppColors.lightCard),
            borderRadius: BorderRadius.circular(10),
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
                size: 14,
                color: _isHovered
                    ? AppColors.primary
                    : (widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTextStyles.labelSmall(
                  _isHovered
                      ? AppColors.primary
                      : (widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingWidget extends StatefulWidget {
  final Widget child;

  const _FloatingWidget({required this.child});

  @override
  State<_FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<_FloatingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
