import '../models/profile_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/skill_model.dart';

/// Abstract repository interface for profile data
abstract class ProfileRepository {
  ProfileModel getProfile();
  List<ExperienceModel> getExperiences();
  List<EducationModel> getEducation();
  List<SkillCategoryModel> getSkillCategories();
  List<SkillModel> getMainSkills();
}

/// Implementation of ProfileRepository with hardcoded CV data
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  ProfileModel getProfile() {
    return const ProfileModel(
      name: 'Akhil Raj',
      title: 'Senior Flutter Developer',
      email: 'akhilraj20801@gmail.com',
      phone: '+91 8943514279',
      heroSummary:
          'Crafting exceptional mobile experiences with Flutter. I build high-performance, scalable apps with clean architecture and pixel-perfect UI that users love.',
      aboutSummary:
          'Results-oriented Senior Flutter Developer with 2.7+ years of experience in architecting, developing, and deploying scalable cross-platform applications using Flutter, Dart, Firebase, and modern architectures. Passionate about creating beautiful, performant mobile experiences with clean code and best practices.',
      location: 'Kerala, India',
      socialLinks: SocialLinks(
        github: 'https://github.com/4khil-raj',
        linkedin: 'https://www.linkedin.com/in/akhil-raj-0b9365284/',
        leetcode: 'https://leetcode.com/u/4khil_Raj/',
      ),
    );
  }

  @override
  List<ExperienceModel> getExperiences() {
    return const [
      ExperienceModel(
        company: 'MotionRay Marketing Consultancy',
        location: 'Malappuram, Kerala',
        role: 'Senior Flutter Developer',
        startDate: 'Nov 2024',
        endDate: 'Present',
        isCurrent: true,
        highlights: [
          'Lead development of cross-platform marketing automation apps serving thousands of users',
          'Mentored junior developers and conducted thorough code reviews to maintain code quality',
          'Designed scalable architectures with Bloc + Domain Driven Design patterns',
          'Integrated third-party APIs, Firebase services, and payment gateways',
          'Optimized performance, reduced crashes by ~30%, and improved load times significantly',
        ],
      ),
      ExperienceModel(
        company: 'Ganlaxmine IT Solutions',
        location: 'Bengaluru, Karnataka',
        role: 'Flutter Developer',
        startDate: 'May 2024',
        endDate: 'Nov 2024',
        highlights: [
          'Developed commercial Flutter apps with REST APIs and Firebase backend integration',
          'Collaborated with UI/UX designers to deliver pixel-perfect user interfaces',
          'Implemented Bloc + Provider for maintainable and testable state management',
          'Worked with CI/CD pipelines for automated testing and deployment',
          'Contributed to agile development cycles with regular sprint deliverables',
        ],
      ),
      ExperienceModel(
        company: 'Brototype',
        location: 'Bengaluru, Karnataka',
        role: 'Flutter Intern',
        startDate: 'July 2023',
        endDate: 'May 2024',
        highlights: [
          'Built multiple Flutter applications with Hive, SQLite, and Firebase databases',
          'Explored various state management solutions including GetX and Provider',
          'Strengthened foundations in software architecture and design patterns',
          'Practiced Agile methodologies and collaborative development workflows',
          'Completed intensive training in Flutter development and mobile app architecture',
        ],
      ),
    ];
  }

  @override
  List<EducationModel> getEducation() {
    return const [
      EducationModel(
        degree: 'Diploma in Computer Engineering',
        institution: 'GPTC Nedumkandam, Idukki, Kerala',
        duration: '2020 - 2023',
        description: 'Specialized in software development and computer fundamentals',
      ),
      EducationModel(
        degree: 'Higher Secondary (Science)',
        institution: 'DBHSS Cheriyanadu, Alappuzha, Kerala',
        duration: '2018 - 2020',
        description: 'Focused on Mathematics and Computer Science',
      ),
    ];
  }

  @override
  List<SkillCategoryModel> getSkillCategories() {
    return const [
      SkillCategoryModel(
        category: 'Languages',
        skills: ['Dart', 'JavaScript'],
        colorIndex: 0,
      ),
      SkillCategoryModel(
        category: 'Frameworks',
        skills: ['Flutter', 'Flutter Web', 'Flutter Desktop'],
        colorIndex: 1,
      ),
      SkillCategoryModel(
        category: 'State Management',
        skills: ['Bloc', 'Cubit', 'Provider', 'GetX', 'Riverpod'],
        colorIndex: 2,
      ),
      SkillCategoryModel(
        category: 'Database',
        skills: ['Firebase Firestore', 'Hive', 'SQLite', 'Shared Preferences'],
        colorIndex: 3,
      ),
      SkillCategoryModel(
        category: 'Backend & APIs',
        skills: ['REST APIs', 'GraphQL', 'Firebase Auth', 'Cloud Functions'],
        colorIndex: 4,
      ),
      SkillCategoryModel(
        category: 'UI & Animations',
        skills: ['Custom Widgets', 'Animations', 'Responsive Design', 'Material 3'],
        colorIndex: 5,
      ),
      SkillCategoryModel(
        category: 'Tools & Version Control',
        skills: ['Git', 'GitHub', 'VS Code', 'Android Studio', 'Postman', 'Figma'],
        colorIndex: 6,
      ),
      SkillCategoryModel(
        category: 'Architecture',
        skills: ['Clean Architecture', 'Domain Driven Design', 'MVVM', 'MVC'],
        colorIndex: 7,
      ),
      SkillCategoryModel(
        category: 'Deployment',
        skills: ['Play Store', 'App Store', 'CI/CD', 'Fastlane', 'Firebase Hosting'],
        colorIndex: 0,
      ),
      SkillCategoryModel(
        category: 'Testing',
        skills: ['Unit Testing', 'Widget Testing', 'Integration Testing'],
        colorIndex: 1,
      ),
    ];
  }

  @override
  List<SkillModel> getMainSkills() {
    return const [
      SkillModel(name: 'Flutter', proficiency: 0.95),
      SkillModel(name: 'Dart', proficiency: 0.92),
      SkillModel(name: 'Bloc/Cubit', proficiency: 0.90),
      SkillModel(name: 'Firebase', proficiency: 0.85),
      SkillModel(name: 'REST APIs', proficiency: 0.88),
      SkillModel(name: 'Git', proficiency: 0.85),
      SkillModel(name: 'Provider', proficiency: 0.88),
      SkillModel(name: 'Clean Architecture', proficiency: 0.85),
      SkillModel(name: 'UI/UX Design', proficiency: 0.82),
      SkillModel(name: 'App Deployment', proficiency: 0.80),
    ];
  }
}
