import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// A skill progress meter widget with animated bar
class SkillMeter extends StatefulWidget {
  final String skillName;
  final double proficiency; // 0.0 to 1.0
  final Color? color;
  final bool showPercentage;
  final Duration animationDuration;

  const SkillMeter({
    super.key,
    required this.skillName,
    required this.proficiency,
    this.color,
    this.showPercentage = true,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  State<SkillMeter> createState() => _SkillMeterState();
}

class _SkillMeterState extends State<SkillMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.proficiency,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final barColor = widget.color ?? AppColors.primaryOrange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skillName,
              style: AppTextStyles.labelLarge(textColor),
            ),
            if (widget.showPercentage)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    '${(_animation.value * 100).toInt()}%',
                    style: AppTextStyles.labelMedium(secondaryColor),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        Container(
          height: AppSizes.progressBarHeight,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface
                : AppColors.lightDivider.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        barColor,
                        barColor.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    boxShadow: [
                      BoxShadow(
                        color: barColor.withValues(alpha: 0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
