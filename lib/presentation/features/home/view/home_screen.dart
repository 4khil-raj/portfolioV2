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

/// Next-Gen 2025/2026 HomeScreen with Ambient Mesh Canvas & Floating Glass Navbar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _activeSectionIndex = 0;

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
    final scrolled = _scrollController.offset > 40;
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

  void _scrollToSection(GlobalKey key, int index) {
    setState(() => _activeSectionIndex = index);
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
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
          // Background Ambient Glow Meshes for Dark Mode Depth
          if (isDark) ...[
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x2006B6D4), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: -150,
              child: Container(
                width: 600,
                height: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x1A8B5CF6), Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: isDesktop ? 90 : 75),
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onContactPressed: () => _scrollToSection(_contactKey, 5),
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
          // Floating Glassmorphic Header Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavBar(context, isDark, isDesktop),
          ),
          // Floating Back-to-Top Button
          if (_isScrolled)
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton.small(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                tooltip: 'Back to Top',
                child: const Icon(Icons.arrow_upward_rounded, size: 20),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool isDark, bool isDesktop) {
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(
          top: _isScrolled && isDesktop ? 12 : 0,
          left: _isScrolled && isDesktop ? AppSizes.xl : 0,
          right: _isScrolled && isDesktop ? AppSizes.xl : 0,
        ),
        constraints: const BoxConstraints(maxWidth: 1300),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? AppSizes.xl : AppSizes.md,
          vertical: AppSizes.sm + 2,
        ),
        decoration: BoxDecoration(
          color: _isScrolled
              ? (isDark
                  ? AppColors.darkCard.withValues(alpha: 0.92)
                  : AppColors.lightCard.withValues(alpha: 0.95))
              : Colors.transparent,
          borderRadius: _isScrolled && isDesktop
              ? BorderRadius.circular(50)
              : BorderRadius.zero,
          border: _isScrolled
              ? Border.all(
                  color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                  width: 1.0,
                )
              : null,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              // Logo
              _Logo(isDark: isDark),
              const SizedBox(width: 10),
              Text(
                'AKHIL RAJ',
                style: AppTextStyles.labelMedium(textColor).copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              // Nav Links (Desktop)
              if (isDesktop) ...[
                _NavLink(
                  label: 'About',
                  isSelected: _activeSectionIndex == 1,
                  onTap: () => _scrollToSection(_aboutKey, 1),
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.lg),
                _NavLink(
                  label: 'Experience',
                  isSelected: _activeSectionIndex == 2,
                  onTap: () => _scrollToSection(_experienceKey, 2),
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.lg),
                _NavLink(
                  label: 'Skills',
                  isSelected: _activeSectionIndex == 3,
                  onTap: () => _scrollToSection(_skillsKey, 3),
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.lg),
                _NavLink(
                  label: 'Education',
                  isSelected: _activeSectionIndex == 4,
                  onTap: () => _scrollToSection(_educationKey, 4),
                  color: secondaryColor,
                ),
                const SizedBox(width: AppSizes.lg),
                _ContactNavButton(
                  onTap: () => _scrollToSection(_contactKey, 5),
                ),
                const SizedBox(width: AppSizes.md),
              ],
              // Theme Toggle
              _ThemeToggle(isDark: isDark),
              // Mobile Menu Button
              if (!isDesktop) ...[
                const SizedBox(width: AppSizes.xs),
                _MobileMenuButton(
                  onTap: () => _showMobileMenu(context, isDark),
                  textColor: textColor,
                ),
              ],
            ],
          ),
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
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
            ),
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
                      _scrollToSection(_aboutKey, 1);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.work_outline_rounded,
                    label: 'Experience',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_experienceKey, 2);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.code_rounded,
                    label: 'Skills',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_skillsKey, 3);
                    },
                    textColor: textColor,
                  ),
                  _MobileMenuItem(
                    icon: Icons.school_outlined,
                    label: 'Education',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(_educationKey, 4);
                    },
                    textColor: textColor,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  SizedBox(
                    width: double.infinity,
                    child: _ContactNavButton(
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection(_contactKey, 5);
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
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      padding: const EdgeInsets.all(2),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightDivider,
        child: ClipOval(
          child: Image.asset(
            'assets/images/download.png',
            height: 32,
            width: 32,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _NavLink({
    required this.label,
    required this.isSelected,
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
    final active = widget.isSelected || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.labelMedium(
                  active ? AppColors.primary : widget.color,
                ).copyWith(fontWeight: active ? FontWeight.bold : FontWeight.w500),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: active ? 18 : 0,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(2),
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact',
                style: AppTextStyles.labelMedium(Colors.white).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
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
              padding: const EdgeInsets.all(8),
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
                size: 18,
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
        padding: const EdgeInsets.all(8),
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
      title: Text(label, style: AppTextStyles.bodyMedium(textColor).copyWith(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
