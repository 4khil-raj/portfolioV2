/// Profile model containing personal information
class ProfileModel {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String summary;
  final String location;
  final SocialLinks socialLinks;

  const ProfileModel({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.summary,
    required this.location,
    required this.socialLinks,
  });
}

/// Social media links
class SocialLinks {
  final String github;
  final String linkedin;
  final String leetcode;

  const SocialLinks({
    required this.github,
    required this.linkedin,
    required this.leetcode,
  });
}
