/// Skill category model containing a group of skills
class SkillCategoryModel {
  final String category;
  final List<String> skills;
  final int colorIndex;

  const SkillCategoryModel({
    required this.category,
    required this.skills,
    required this.colorIndex,
  });
}

/// Individual skill model with proficiency level
class SkillModel {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String? iconPath;

  const SkillModel({
    required this.name,
    required this.proficiency,
    this.iconPath,
  });
}
