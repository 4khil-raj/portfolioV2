import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Modern 2025 About section with bento grid style and image
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
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
                  const SectionTitle(title: AppStrings.about),
                  const SizedBox(height: AppSizes.xxl),
                  // Summary text
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Text(
                      profile.aboutSummary,
                      style: AppTextStyles.bodyLarge(secondaryColor).copyWith(
                        height: 1.8,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl * 1.5),
                  // Bento Grid with Image, Stats & Skills
                  isMobile
                      ? _buildMobileGrid(isDark, textColor, secondaryColor)
                      : _buildDesktopGrid(isDark, textColor, secondaryColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopGrid(bool isDark, Color textColor, Color secondaryColor) {
    return Column(
      children: [
        // Top row: Image + Stats
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Card - Larger size
            Expanded(
              flex: 3,
              child: _ProfileImageCard(isDark: isDark),
            ),
            const SizedBox(width: AppSizes.lg),
            // Stats column
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          value: AppStrings.yearsExperience,
                          label: AppStrings.yearsLabel,
                          icon: Icons.work_history_rounded,
                          color: AppColors.primary,
                          isDark: isDark,
                          textColor: textColor,
                          secondaryColor: secondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Expanded(
                        child: _StatCard(
                          value: AppStrings.projectsCompleted,
                          label: AppStrings.projectsLabel,
                          icon: Icons.rocket_launch_rounded,
                          color: AppColors.secondary,
                          isDark: isDark,
                          textColor: textColor,
                          secondaryColor: secondaryColor,
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Expanded(
                        child: _StatCard(
                          value: AppStrings.companiesWorked,
                          label: AppStrings.companiesLabel,
                          icon: Icons.business_rounded,
                          color: AppColors.accent,
                          isDark: isDark,
                          textColor: textColor,
                          secondaryColor: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.md),
                  _SkillsCard(
                    isDark: isDark,
                    textColor: textColor,
                    secondaryColor: secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileGrid(bool isDark, Color textColor, Color secondaryColor) {
    return Column(
      children: [
        // Profile Image
        _ProfileImageCard(isDark: isDark, isMobile: true),
        const SizedBox(height: AppSizes.md),
        // Stats row
        Row(
          children: [
            Expanded(
              child: _StatCard(
                value: AppStrings.yearsExperience,
                label: AppStrings.yearsLabel,
                icon: Icons.work_history_rounded,
                color: AppColors.primary,
                isDark: isDark,
                textColor: textColor,
                secondaryColor: secondaryColor,
              ),
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: _StatCard(
                value: AppStrings.projectsCompleted,
                label: AppStrings.projectsLabel,
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
        _StatCard(
          value: AppStrings.companiesWorked,
          label: AppStrings.companiesLabel,
          icon: Icons.business_rounded,
          color: AppColors.accent,
          isDark: isDark,
          textColor: textColor,
          secondaryColor: secondaryColor,
          isWide: true,
        ),
        const SizedBox(height: AppSizes.md),
        _SkillsCard(
          isDark: isDark,
          textColor: textColor,
          secondaryColor: secondaryColor,
        ),
      ],
    );
  }
}

/// Modern profile image card with gradient border
class _ProfileImageCard extends StatefulWidget {
  final bool isDark;
  final bool isMobile;

  const _ProfileImageCard({
    required this.isDark,
    this.isMobile = false,
  });

  @override
  State<_ProfileImageCard> createState() => _ProfileImageCardState();
}

class _ProfileImageCardState extends State<_ProfileImageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.isMobile ? 350 : 480,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: _isHovered ? 0.8 : 0.6),
              AppColors.secondary.withValues(alpha: _isHovered ? 0.8 : 0.6),
            ],
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.asset(
                  'assets/images/IMG_4176.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.2),
                            AppColors.secondary.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 60,
                              color: AppColors.primary.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: AppSizes.md),
                            Text(
                              'Akhil Raj',
                              style: AppTextStyles.titleLarge(
                                widget.isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Akhil Raj',
                          style: AppTextStyles.titleMedium(Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Senior Flutter Developer',
                          style: AppTextStyles.labelSmall(Colors.white.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final bool isWide;

  const _StatCard({
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
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(widget.isWide ? AppSizes.lg : AppSizes.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.4)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: widget.isWide
            ? Row(
                children: [
                  _buildIcon(),
                  const SizedBox(width: AppSizes.lg),
                  Expanded(child: _buildContent()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIcon(),
                  const SizedBox(height: AppSizes.lg),
                  _buildContent(),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        widget.icon,
        color: widget.color,
        size: 24,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.value,
          style: AppTextStyles.statNumber(widget.textColor).copyWith(fontSize: 36),
        ),
        const SizedBox(height: 4),
        Text(
          widget.label,
          style: AppTextStyles.labelMedium(widget.secondaryColor),
        ),
      ],
    );
  }
}

class _SkillsCard extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;

  const _SkillsCard({
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final skills = [
      _Skill('Flutter & Dart', Icons.flutter_dash, AppColors.primary),
      _Skill('Bloc & Provider', Icons.account_tree_rounded, AppColors.secondary),
      _Skill('Clean Architecture', Icons.architecture, AppColors.accentPink),
      _Skill('Firebase & APIs', Icons.cloud_rounded, AppColors.accent),
      _Skill('UI/UX Design', Icons.design_services_rounded, AppColors.accentWarm),
      _Skill('App Deployment', Icons.rocket_launch, AppColors.info),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Text(
                'What I Do',
                style: AppTextStyles.titleMedium(textColor),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xl),
          Wrap(
            spacing: AppSizes.sm,
            runSpacing: AppSizes.sm,
            children: skills.map((skill) => _SkillChip(
              skill: skill,
              isDark: isDark,
              textColor: textColor,
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _Skill {
  final String name;
  final IconData icon;
  final Color color;

  _Skill(this.name, this.icon, this.color);
}

class _SkillChip extends StatefulWidget {
  final _Skill skill;
  final bool isDark;
  final Color textColor;

  const _SkillChip({
    required this.skill,
    required this.isDark,
    required this.textColor,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.skill.color.withValues(alpha: 0.1)
              : (widget.isDark ? AppColors.darkSurface : AppColors.lightBackground),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? widget.skill.color.withValues(alpha: 0.4)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.skill.icon,
              size: 18,
              color: _isHovered ? widget.skill.color : widget.textColor,
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: AppTextStyles.labelMedium(
                _isHovered ? widget.skill.color : widget.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
