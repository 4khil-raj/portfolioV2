import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_theme_cubit.dart';
import '../../about/view/about_section.dart';
import '../../contact/view/contact_section.dart';
import '../../education/view/education_section.dart';
import '../../experience/view/experience_section.dart';
import '../../skills/view/skills_section.dart';
import 'widgets/hero_section.dart';

/// Main home screen containing all portfolio sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Keys for each section to enable scroll navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppSizes.tabletBreakpoint;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Column(
        children: [
          // App bar / Navigation
          _buildAppBar(context, isDark, isDesktop),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: _heroKey,
                    child: HeroSection(
                      onContactPressed: () => _scrollToSection(_contactKey),
                    ),
                  ),
                  // About Section
                  Container(
                    key: _aboutKey,
                    child: const AboutSection(),
                  ),
                  // Experience Section
                  Container(
                    key: _experienceKey,
                    child: const ExperienceSection(),
                  ),
                  // Skills Section
                  Container(
                    key: _skillsKey,
                    child: const SkillsSection(),
                  ),
                  // Education Section
                  Container(
                    key: _educationKey,
                    child: const EducationSection(),
                  ),
                  // Contact Section
                  Container(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),
                  // Footer
                  _buildFooter(context, isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark, bool isDesktop) {
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withValues(alpha: 0.9)
            : AppColors.lightBackground.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Logo / Name
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ).createShader(bounds),
              child: Text(
                'AR',
                style: AppTextStyles.headlineMedium(Colors.white),
              ),
            ),
            const Spacer(),
            // Navigation links (desktop only)
            if (isDesktop) ...[
              _buildNavItem('About', () => _scrollToSection(_aboutKey), secondaryColor),
              const SizedBox(width: AppSizes.lg),
              _buildNavItem('Experience', () => _scrollToSection(_experienceKey), secondaryColor),
              const SizedBox(width: AppSizes.lg),
              _buildNavItem('Skills', () => _scrollToSection(_skillsKey), secondaryColor),
              const SizedBox(width: AppSizes.lg),
              _buildNavItem('Education', () => _scrollToSection(_educationKey), secondaryColor),
              const SizedBox(width: AppSizes.lg),
              _buildNavItem('Contact', () => _scrollToSection(_contactKey), secondaryColor),
              const SizedBox(width: AppSizes.lg),
            ],
            // Theme toggle button
            BlocBuilder<AppThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return _ThemeToggleButton(
                  isDark: isDark,
                  onToggle: () {
                    context.read<AppThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
            // Mobile menu button
            if (!isDesktop) ...[
              const SizedBox(width: AppSizes.sm),
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: textColor,
                ),
                onPressed: () => _showMobileMenu(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, VoidCallback onTap, Color color) {
    return _NavItem(label: label, onTap: onTap, color: color);
  }

  void _showMobileMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXl)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSizes.lg),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                _buildMobileMenuItem('About', Icons.person_outline_rounded, () {
                  Navigator.pop(context);
                  _scrollToSection(_aboutKey);
                }, textColor),
                _buildMobileMenuItem('Experience', Icons.work_outline_rounded, () {
                  Navigator.pop(context);
                  _scrollToSection(_experienceKey);
                }, textColor),
                _buildMobileMenuItem('Skills', Icons.code_rounded, () {
                  Navigator.pop(context);
                  _scrollToSection(_skillsKey);
                }, textColor),
                _buildMobileMenuItem('Education', Icons.school_outlined, () {
                  Navigator.pop(context);
                  _scrollToSection(_educationKey);
                }, textColor),
                _buildMobileMenuItem('Contact', Icons.mail_outline_rounded, () {
                  Navigator.pop(context);
                  _scrollToSection(_contactKey);
                }, textColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(
      String label, IconData icon, VoidCallback onTap, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryOrange),
      title: Text(label, style: AppTextStyles.bodyLarge(textColor)),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark) {
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.footerText,
            style: AppTextStyles.bodySmall(secondaryColor),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            AppStrings.copyright,
            style: AppTextStyles.bodySmall(secondaryColor),
          ),
        ],
      ),
    );
  }
}

/// Navigation item widget with hover effect
class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _NavItem({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: AppSizes.xs,
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge(
              _isHovered ? AppColors.primaryOrange : widget.color,
            ),
          ),
        ),
      ),
    );
  }
}

/// Theme toggle button with animation
class _ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _ThemeToggleButton({
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface
              : AppColors.lightDivider.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            size: AppSizes.iconMd,
            color: isDark ? AppColors.warning : AppColors.primaryOrange,
          ),
        ),
      ),
    );
  }
}
