/// Education model containing academic information
class EducationModel {
  final String degree;
  final String institution;
  final String duration;
  final String? description;

  const EducationModel({
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
  });
}
