/// Experience model containing work history information
class ExperienceModel {
  final String company;
  final String location;
  final String role;
  final String startDate;
  final String endDate;
  final List<String> highlights;
  final bool isCurrent;

  const ExperienceModel({
    required this.company,
    required this.location,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.highlights,
    this.isCurrent = false,
  });

  /// Returns formatted duration string
  String get duration => '$startDate - $endDate';
}
