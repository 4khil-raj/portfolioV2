import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Ultra-Modern Bento Grid About Section
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final isTablet = screenWidth < AppSizes.tabletBreakpoint;

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
              constraints: const BoxConstraints(maxWidth: 1250),
              child: Column(
                children: [
                  ScrollFadeIn(
                    key: const ValueKey('about_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: AppStrings.about),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('about_subtitle'),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Architecting clean, resilient cross-platform applications',
                      style: AppTextStyles.bodyMedium(secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Bento Grid
                  isMobile || isTablet
                      ? _buildMobileBentoGrid(context, profile, isDark, textColor, secondaryColor)
                      : _buildDesktopBentoGrid(context, profile, isDark, textColor, secondaryColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopBentoGrid(
    BuildContext context,
    dynamic profile,
    bool isDark,
    Color textColor,
    Color secondaryColor,
  ) {
    return Column(
      children: [
        // Row 1: Bio Card (Expanded) + Stat Cards Column
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bio Card with Tab Switcher
            Expanded(
              flex: 6,
              child: ScrollSlideIn(
                key: const ValueKey('bento_bio'),
                direction: SlideDirection.left,
                duration: const Duration(milliseconds: 750),
                child: _BentoBioCard(
                  profile: profile,
                  isDark: isDark,
                  textColor: textColor,
                  secondaryColor: secondaryColor,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.lg),
            // Stats Grid Column
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ScrollReveal(
                          key: const ValueKey('bento_stat_1'),
                          delay: const Duration(milliseconds: 200),
                          child: _BentoStatCard(
                            value: '3+',
                            label: 'Years Exp',
                            icon: Icons.history_edu_rounded,
                            color: AppColors.primary,
                            isDark: isDark,
                            textColor: textColor,
                            secondaryColor: secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Expanded(
                        child: ScrollReveal(
                          key: const ValueKey('bento_stat_2'),
                          delay: const Duration(milliseconds: 300),
                          child: _BentoStatCard(
                            value: '10+',
                            label: 'Apps Delivered',
                            icon: Icons.rocket_launch_rounded,
                            color: AppColors.secondary,
                            isDark: isDark,
                            textColor: textColor,
                            secondaryColor: secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollSlideIn(
                    key: const ValueKey('bento_stat_3'),
                    direction: SlideDirection.right,
                    delay: const Duration(milliseconds: 400),
                    child: _BentoStatCard(
                      value: 'AI-Assisted Dev',
                      label: 'Vibe Coding & Smart Workflows',
                      icon: Icons.auto_awesome_rounded,
                      color: AppColors.secondary,
                      isDark: isDark,
                      textColor: textColor,
                      secondaryColor: secondaryColor,
                      isWide: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.lg),
        // Row 2: Interactive IDE Code Sandbox Card + Core Competencies Card
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Code Sandbox Card
            Expanded(
              flex: 6,
              child: ScrollSlideIn(
                key: const ValueKey('bento_code'),
                direction: SlideDirection.left,
                delay: const Duration(milliseconds: 500),
                child: _BentoCodeSandboxCard(isDark: isDark),
              ),
            ),
            const SizedBox(width: AppSizes.lg),
            // Core Competencies Card
            Expanded(
              flex: 5,
              child: ScrollSlideIn(
                key: const ValueKey('bento_strengths'),
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 600),
                child: _BentoCompetenciesCard(
                  isDark: isDark,
                  textColor: textColor,
                  secondaryColor: secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileBentoGrid(
    BuildContext context,
    dynamic profile,
    bool isDark,
    Color textColor,
    Color secondaryColor,
  ) {
    return Column(
      children: [
        _BentoBioCard(
          profile: profile,
          isDark: isDark,
          textColor: textColor,
          secondaryColor: secondaryColor,
        ),
        const SizedBox(height: AppSizes.md),
        Row(
          children: [
            Expanded(
              child: _BentoStatCard(
                value: '3+',
                label: 'Years Exp',
                icon: Icons.history_edu_rounded,
                color: AppColors.primary,
                isDark: isDark,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: _BentoStatCard(
                value: '10+',
                label: 'Apps Delivered',
                icon: Icons.rocket_launch_rounded,
                color: AppColors.secondary,
                isDark: isDark,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.md),
        _BentoStatCard(
          value: 'AI-Assisted Dev',
          label: 'Vibe Coding & Smart Workflows',
          icon: Icons.auto_awesome_rounded,
          color: AppColors.secondary,
          isDark: isDark,
          textColor: textColor,
          secondaryColor: secondaryColor,
          isWide: true,
        ),
        const SizedBox(height: AppSizes.md),
        _BentoCodeSandboxCard(isDark: isDark),
        const SizedBox(height: AppSizes.md),
        _BentoCompetenciesCard(
          isDark: isDark,
          textColor: textColor,
          secondaryColor: secondaryColor,
        ),
      ],
    );
  }
}

class _BentoBioCard extends StatefulWidget {
  final dynamic profile;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;

  const _BentoBioCard({
    required this.profile,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  State<_BentoBioCard> createState() => _BentoBioCardState();
}

class _BentoBioCardState extends State<_BentoBioCard> {
  int _selectedTab = 0; // 0: Overview, 1: Architecture, 2: Values

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Avatar & Tabs
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Engineering Philosophy',
                      style: AppTextStyles.titleMedium(widget.textColor).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.profile.location,
                      style: AppTextStyles.labelSmall(AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          // Interactive Tab Filter Pills
          Row(
            children: [
              _buildTabPill('Executive Bio', 0),
              const SizedBox(width: 8),
              _buildTabPill('Architecture', 1),
              const SizedBox(width: 8),
              _buildTabPill('Core Values', 2),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          // Tab Content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: KeyedSubtree(
              key: ValueKey(_selectedTab),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall(
            isSelected ? AppColors.primary : widget.secondaryColor,
          ).copyWith(fontWeight: isSelected ? FontWeight.bold : FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTab == 0) {
      return Text(
        widget.profile.aboutSummary,
        style: AppTextStyles.bodyMedium(widget.secondaryColor).copyWith(height: 1.7),
      );
    } else if (_selectedTab == 1) {
      return Text(
        'I specialize in Domain-Driven Design (DDD) combined with Bloc state management. I structure projects into distinct Presentation, Domain, and Data layers to guarantee testability, maintainability, and clean dependency inversion.',
        style: AppTextStyles.bodyMedium(widget.secondaryColor).copyWith(height: 1.7),
      );
    } else {
      return Text(
        'Pixel perfection, non-blocking asynchronous flow, zero-tolerance for unhandled crash vectors, and strict code review standards. I build software designed to scale gracefully with user demand.',
        style: AppTextStyles.bodyMedium(widget.secondaryColor).copyWith(height: 1.7),
      );
    }
  }
}

class _BentoStatCard extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final bool isWide;

  const _BentoStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    this.isWide = false,
  });

  @override
  State<_BentoStatCard> createState() => _BentoStatCardState();
}

class _BentoStatCardState extends State<_BentoStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.5)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: widget.isWide
            ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 24),
                  ),
                  const SizedBox(width: AppSizes.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.value,
                          style: AppTextStyles.statNumber(widget.textColor).copyWith(
                            fontSize: widget.value.length > 6 ? 24 : 32,
                          ),
                        ),
                        Text(
                          widget.label,
                          style: AppTextStyles.labelMedium(widget.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 22),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Text(
                    widget.value,
                    style: AppTextStyles.statNumber(widget.textColor).copyWith(fontSize: 34),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.label,
                    style: AppTextStyles.labelSmall(widget.secondaryColor),
                  ),
                ],
              ),
      ),
    );
  }
}

class _BentoCodeSandboxCard extends StatelessWidget {
  final bool isDark;

  const _BentoCodeSandboxCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0B132B) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDE Window Bar Header
          Row(
            children: [
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Text(
                'clean_architecture.dart',
                style: AppTextStyles.mono(const Color(0xFF94A3B8)).copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          const Divider(color: Color(0xFF334155), height: 1),
          const SizedBox(height: AppSizes.md),
          // Code Snippet with Syntax Highlighting Colors
          RichText(
            text: TextSpan(
              style: AppTextStyles.mono(const Color(0xFFF8FAFC)).copyWith(fontSize: 13, height: 1.6),
              children: const [
                TextSpan(text: 'class ', style: TextStyle(color: Color(0xFFEC4899), fontWeight: FontWeight.bold)),
                TextSpan(text: 'FlutterAppArchitecture ', style: TextStyle(color: Color(0xFF38BDF8))),
                TextSpan(text: '{\n'),
                TextSpan(text: '  final ', style: TextStyle(color: Color(0xFFEC4899))),
                TextSpan(text: 'BlocPattern ', style: TextStyle(color: Color(0xFF8B5CF6))),
                TextSpan(text: 'stateManagement;\n'),
                TextSpan(text: '  final ', style: TextStyle(color: Color(0xFFEC4899))),
                TextSpan(text: 'DomainRepository ', style: TextStyle(color: Color(0xFF8B5CF6))),
                TextSpan(text: 'cleanDomain;\n\n'),
                TextSpan(text: '  void ', style: TextStyle(color: Color(0xFF10B981))),
                TextSpan(text: 'deployApp', style: TextStyle(color: Color(0xFFF59E0B))),
                TextSpan(text: '() {\n'),
                TextSpan(text: '    stateManagement.emit('),
                TextSpan(text: 'HighPerformanceState', style: TextStyle(color: Color(0xFF38BDF8))),
                TextSpan(text: '());\n'),
                TextSpan(text: '  }\n'),
                TextSpan(text: '}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoCompetenciesCard extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;

  const _BentoCompetenciesCard({
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final competencies = [
      _Competency('Clean Architecture', Icons.architecture, AppColors.primary),
      _Competency('Bloc & Cubit', Icons.account_tree_rounded, AppColors.secondary),
      _Competency('~30% Crash Reduction', Icons.shield_rounded, AppColors.accent),
      _Competency('REST & GraphQL', Icons.api_rounded, AppColors.primaryLight),
      _Competency('Firebase Cloud', Icons.cloud_done_rounded, AppColors.accentWarm),
      _Competency('Local Database', Icons.storage_rounded, AppColors.accentPink),
      _Competency('CI/CD & Fastlane', Icons.rocket_launch_rounded, AppColors.info),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.star_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: AppSizes.md),
              Text(
                'Key Specialties',
                style: AppTextStyles.titleMedium(textColor).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: competencies.map((comp) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(comp.icon, size: 16, color: comp.color),
                    const SizedBox(width: 6),
                    Text(
                      comp.name,
                      style: AppTextStyles.labelSmall(textColor).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Competency {
  final String name;
  final IconData icon;
  final Color color;

  _Competency(this.name, this.icon, this.color);
}
