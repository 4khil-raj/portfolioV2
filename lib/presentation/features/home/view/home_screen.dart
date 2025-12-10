import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_theme_cubit.dart';
import '../../about/view/about_section.dart';
import '../../contact/view/contact_section.dart';
import '../../education/view/education_section.dart';
import '../../experience/view/experience_section.dart';
import '../../skills/view/skills_section.dart';
import 'widgets/hero_section.dart';

/// Modern 2025 Home Screen with glassmorphism nav
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
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
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Add padding for nav bar
                SizedBox(height: isDesktop ? 80 : 70),
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onContactPressed: () => _scrollToSection(_contactKey),
                  ),
                ),
                Container(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                Container(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),
                Container(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),
                Container(
                  key: _educationKey,
                  child: const EducationSection(),
                ),
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),
          // Floating nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavBar(context, isDark, isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool isDark, bool isDesktop) {
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? AppSizes.xxl : AppSizes.lg,
        vertical: AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? (isDark
                ? AppColors.darkBackground.withValues(alpha: 0.95)
                : AppColors.lightBackground.withValues(alpha: 0.95))
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? (isDark ? AppColors.darkDivider : AppColors.lightDivider)
                : Colors.transparent,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Logo
            _Logo(isDark: isDark),
            const Spacer(),
            // Navigation links (desktop)
            if (isDesktop) ...[
              _NavLink(
                label: 'About',
                onTap: () => _scrollToSection(_aboutKey),
                color: secondaryColor,
              ),
              const SizedBox(width: AppSizes.xl),
              _NavLink(
                label: 'Experience',
                onTap: () => _scrollToSection(_experienceKey),
                color: secondaryColor,
              ),
              const SizedBox(width: AppSizes.xl),
              _NavLink(
                label: 'Skills',
                onTap: () => _scrollToSection(_skillsKey),
                color: secondaryColor,
              ),
              const SizedBox(width: AppSizes.xl),
              _NavLink(
                label: 'Education',
                onTap: () => _scrollToSection(_educationKey),
                color: secondaryColor,
              ),
              const SizedBox(width: AppSizes.xl),
              _ContactNavButton(
                onTap: () => _scrollToSection(_contactKey),
              ),
              const SizedBox(width: AppSizes.lg),
            ],
            // Theme toggle
            _ThemeToggle(isDark: isDark),
            // Mobile menu
            if (!isDesktop) ...[
              const SizedBox(width: AppSizes.sm),
              _MobileMenuButton(
                onTap: () => _showMobileMenu(context, isDark),
                textColor: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, bool isDark) {
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SafeArea(
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
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  _MobileMenuItem(
                    icon: Icons.person_outline_rounded,
                    label: 'About',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_aboutKey);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.work_outline_rounded,
                    label: 'Experience',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_experienceKey);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.code_rounded,
                    label: 'Skills',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_skillsKey);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.school_outlined,
                    label: 'Education',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_educationKey);
                    },
                    textColor: textColor,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  SizedBox(
                    width: double.infinity,
                    child: _ContactNavButton(
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(_contactKey);
                      },
                      isFullWidth: true,
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

class _Logo extends StatelessWidget {
  final bool isDark;

  const _Logo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightDivider,
      child: ClipOval(
        child: Image.asset(
          'assets/images/download.png',
          height: 36,
          width: 36,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _NavLink({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.labelMedium(
                  _isHovered ? AppColors.primary : widget.color,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isHovered ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactNavButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isFullWidth;

  const _ContactNavButton({
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  State<_ContactNavButton> createState() => _ContactNavButtonState();
}

class _ContactNavButtonState extends State<_ContactNavButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [AppColors.primaryDark, AppColors.primary]
                  : [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact',
                style: AppTextStyles.labelMedium(Colors.white),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  final bool isDark;

  const _ThemeToggle({required this.isDark});

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () => context.read<AppThemeCubit>().toggleTheme(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovered
                    ? (widget.isDark ? AppColors.darkSurface : AppColors.lightDivider)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
              ),
              child: Icon(
                widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 20,
                color: widget.isDark ? AppColors.warning : AppColors.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color textColor;

  const _MobileMenuButton({
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(
          Icons.menu_rounded,
          color: textColor,
          size: 24,
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color textColor;

  const _MobileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTextStyles.bodyMedium(textColor)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
