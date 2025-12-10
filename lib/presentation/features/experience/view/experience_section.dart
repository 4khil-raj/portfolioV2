import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../common/widgets/section_title.dart';
import '../../../common/widgets/timeline_tile.dart';
import '../../home/view_model/home_cubit.dart';

/// Experience section widget displaying work history timeline
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final experiences = state.experiences;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.lg : AppSizes.xxl,
            vertical: isMobile ? AppSizes.sectionPaddingMobile : AppSizes.sectionPadding,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(alpha: 0.3)
                : AppColors.lightBackground,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Column(
                children: [
                  const SectionTitle(title: AppStrings.experience),
                  const SizedBox(height: AppSizes.xl),
                  // Experience timeline
                  ...experiences.asMap().entries.map((entry) {
                    final index = entry.key;
                    final experience = entry.value;
                    return TimelineTile(
                      title: experience.role,
                      subtitle: experience.company,
                      duration: experience.duration,
                      location: experience.location,
                      highlights: experience.highlights,
                      isFirst: index == 0,
                      isLast: index == experiences.length - 1,
                      isCurrent: experience.isCurrent,
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
