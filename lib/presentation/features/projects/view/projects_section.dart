import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/scroll_animations.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../../common/widgets/section_title.dart';
import '../../home/view_model/home_cubit.dart';

/// Modern Projects Showcase Section
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final isTablet = screenWidth < AppSizes.tabletBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final projects = state.projects;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl * 2,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  ScrollFadeIn(
                    key: const ValueKey('projects_title'),
                    duration: const Duration(milliseconds: 600),
                    child: const SectionTitle(title: 'Featured Projects'),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ScrollFadeIn(
                    key: const ValueKey('projects_subtitle'),
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'High-performance production applications & architectural solutions',
                      style: AppTextStyles.bodyMedium(
                        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  // Grid of projects
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                      crossAxisSpacing: AppSizes.lg,
                      mainAxisSpacing: AppSizes.lg,
                      childAspectRatio: isMobile ? 0.95 : 0.82,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return ScrollReveal(
                        key: ValueKey('project_card_$index'),
                        delay: Duration(milliseconds: 150 + (index * 150)),
                        child: _ProjectCard(
                          project: project,
                          isDark: isDark,
                          index: index,
                        ),
                      );
                    },
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

class _ProjectCard extends StatefulWidget {
  final dynamic project;
  final bool isDark;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.index,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final accentColors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
    ];
    final cardAccent = accentColors[widget.index % accentColors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(AppSizes.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? cardAccent.withValues(alpha: 0.5)
                : (widget.isDark ? AppColors.darkDivider : AppColors.lightDivider),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: cardAccent.withValues(alpha: 0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: widget.isDark ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header: Icon & GitHub link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.folder_special_rounded,
                    color: cardAccent,
                    size: 24,
                  ),
                ),
                if (widget.project.githubUrl != null)
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      size: 18,
                      color: _isHovered ? cardAccent : secondaryColor,
                    ),
                    onPressed: () => UrlLauncherUtil.openGitHub(widget.project.githubUrl!),
                    tooltip: 'View Source Code',
                  ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            // Title
            Text(
              widget.project.title,
              style: AppTextStyles.titleMedium(textColor).copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSizes.sm),
            // Description
            Expanded(
              child: Text(
                widget.project.description,
                style: AppTextStyles.bodySmall(secondaryColor).copyWith(
                  height: 1.6,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppSizes.md),
            // Tech stack tags
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (widget.project.technologies as List<String>).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? AppColors.darkSurface
                        : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: widget.isDark ? AppColors.darkDivider : AppColors.lightDivider,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: AppTextStyles.labelSmall(cardAccent).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
