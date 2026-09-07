import '../models/profile_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';

/// Abstract repository interface for profile data
abstract class ProfileRepository {
  ProfileModel getProfile();
  List<ExperienceModel> getExperiences();
  List<EducationModel> getEducation();
  List<SkillCategoryModel> getSkillCategories();
  List<SkillModel> getMainSkills();
  List<ProjectModel> getProjects();
}

/// Implementation of ProfileRepository with hardcoded CV data matching latest resume
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  ProfileModel getProfile() {
    return const ProfileModel(
      name: 'Akhil Raj',
      title: 'Senior Flutter Developer',
      email: 'akhilraj20801@gmail.com',
      phone: '+91 8943514279',
      heroSummary:
          'Crafting exceptional cross-platform experiences with Flutter, Dart & AI-Assisted Workflows. I build high-performance, scalable apps with clean architecture, domain-driven design, and pixel-perfect UI.',
      aboutSummary:
          'Results-oriented Senior Flutter Developer with 3+ years of professional experience architecting, developing, and deploying scalable cross-platform mobile applications. Skilled in Flutter, Dart, Firebase, REST APIs, GraphQL, WebSockets, Payment Gateways, Bloc/Provider/GetX/Riverpod, unit and widget testing, native Android/iOS platform integration, and AI-Assisted Development (GitHub Copilot, Claude API) using modern Vibe Coding Workflows. Proven track record delivering high-performance, production-grade apps, mentoring junior developers, and collaborating cross-functionally in Agile/Scrum teams to meet business goals.',
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
          'Lead the development of high-performance cross-platform mobile apps for marketing automation and client solutions, collaborating cross-functionally with product and design stakeholders.',
          'Mentored junior developers, conducted code reviews, and improved development efficiency across the team.',
          'Designed and implemented scalable architectures using Bloc + Domain Driven Design, incorporating unit and widget testing to maintain code reliability across sprints.',
          'Integrated third-party APIs, Firebase services (including FCM push notifications), WebSockets for real-time data, and Payment Gateways for real-time client applications.',
          'Managed release pipelines and app store submissions via Play Console and App Store Connect, streamlining CI/CD deployment.',
          'Optimized app performance, reducing crashes by 30% and improving load times.',
          'Adopted AI-Assisted Development practices with GitHub Copilot and the Claude API, using Vibe Coding Workflows to accelerate feature delivery and improve code quality.',
        ],
      ),
      ExperienceModel(
        company: 'Ganlaxmine IT Solutions',
        location: 'Bengaluru, Karnataka',
        role: 'Flutter Developer',
        startDate: 'May 2024',
        endDate: 'Nov 2024',
        highlights: [
          'Developed commercial Flutter apps with REST API integration, Firebase backend, and CI/CD pipelines (GitHub Actions/Codemagic).',
          'Collaborated in Agile/Scrum sprints with cross-functional teams including UI/UX designers to deliver pixel-perfect, responsive applications.',
          'Implemented state management using Bloc and Provider to ensure long-term maintainability and testability.',
        ],
      ),
      ExperienceModel(
        company: 'Brototype',
        location: 'Bengaluru, Karnataka',
        role: 'Flutter Intern',
        startDate: 'July 2023',
        endDate: 'May 2024',
        highlights: [
          'Gained hands-on experience in Flutter app development through multiple end-to-end projects.',
          'Built apps using Hive, SQLite, and Firebase, and explored GetX state management.',
          'Strengthened understanding of software architecture, unit testing fundamentals, and Agile methodologies.',
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
        duration: '2020 – 2023',
        description: 'Specialized in software development, data structures, and computer fundamentals',
      ),
      EducationModel(
        degree: 'Higher Secondary (Science)',
        institution: 'DBHSS Cheriyanadu, Alappuzha, Kerala',
        duration: '2018 – 2020',
        description: 'Focused on Mathematics, Physics, and Computer Science',
      ),
    ];
  }

  @override
  List<SkillCategoryModel> getSkillCategories() {
    return const [
      SkillCategoryModel(
        category: 'Languages',
        skills: ['Dart'],
        colorIndex: 0,
      ),
      SkillCategoryModel(
        category: 'Frameworks',
        skills: ['Flutter'],
        colorIndex: 1,
      ),
      SkillCategoryModel(
        category: 'State Management',
        skills: ['Bloc', 'Provider', 'GetX', 'Riverpod'],
        colorIndex: 2,
      ),
      SkillCategoryModel(
        category: 'Database',
        skills: ['Firebase', 'Hive', 'SQLite'],
        colorIndex: 3,
      ),
      SkillCategoryModel(
        category: 'Backend',
        skills: ['REST APIs', 'GraphQL', 'WebSockets', 'Payment Gateways'],
        colorIndex: 4,
      ),
      SkillCategoryModel(
        category: 'Testing',
        skills: ['Unit Testing', 'Widget Testing', 'Integration Testing'],
        colorIndex: 5,
      ),
      SkillCategoryModel(
        category: 'Native Integration',
        skills: ['Platform Channels', 'Android (Kotlin) & iOS (Swift) basics'],
        colorIndex: 6,
      ),
      SkillCategoryModel(
        category: 'Tools',
        skills: ['Git', 'GitHub', 'Postman', 'Swagger', 'Figma', 'Canva', 'Jira'],
        colorIndex: 7,
      ),
      SkillCategoryModel(
        category: 'Architecture',
        skills: ['Domain Driven Design', 'Clean Architecture', 'MVC', 'MVVM'],
        colorIndex: 0,
      ),
      SkillCategoryModel(
        category: 'Process',
        skills: ['Agile/Scrum', 'Sprint Planning', 'Cross-functional Collaboration'],
        colorIndex: 1,
      ),
      SkillCategoryModel(
        category: 'Deployment',
        skills: ['CI/CD (GitHub Actions, Codemagic)', 'Play Console', 'App Store Connect'],
        colorIndex: 2,
      ),
      SkillCategoryModel(
        category: 'AI-Assisted Development',
        skills: ['GitHub Copilot', 'Claude API', 'Vibe Coding Workflows'],
        colorIndex: 3,
      ),
    ];
  }

  @override
  List<SkillModel> getMainSkills() {
    return const [
      SkillModel(name: 'Flutter & Dart', proficiency: 0.95),
      SkillModel(name: 'Bloc / Provider / GetX / Riverpod', proficiency: 0.92),
      SkillModel(name: 'AI-Assisted Dev (Copilot & Claude API)', proficiency: 0.92),
      SkillModel(name: 'Domain Driven Design & Clean Arch', proficiency: 0.90),
      SkillModel(name: 'REST APIs, GraphQL & WebSockets', proficiency: 0.88),
      SkillModel(name: 'Firebase, Hive & SQLite', proficiency: 0.88),
      SkillModel(name: 'CI/CD, Play Console & App Store', proficiency: 0.85),
      SkillModel(name: 'Unit, Widget & Integration Testing', proficiency: 0.85),
      SkillModel(name: 'Native Integration (Kotlin/Swift basics)', proficiency: 0.82),
      SkillModel(name: 'Agile/Scrum & Cross-functional Lead', proficiency: 0.88),
    ];
  }

  @override
  List<ProjectModel> getProjects() {
    return const [
      ProjectModel(
        title: 'Marketing Automation Suite',
        description:
            'Cross-platform mobile application for real-time lead analytics, campaign scheduling, and team performance tracking built for MotionRay.',
        technologies: ['Flutter', 'Dart', 'Bloc', 'REST APIs', 'Firebase Cloud Messaging'],
        githubUrl: 'https://github.com/4khil-raj',
      ),
      ProjectModel(
        title: 'VehicleCare Fleet & Maintenance',
        description:
            'Comprehensive vehicle service, maintenance tracking, and telemetry analytics platform built with Clean Architecture, SQLite, and custom chart visualizations.',
        technologies: ['Flutter', 'Bloc', 'Drift/SQLite', 'Clean Architecture', 'Custom Painters'],
        githubUrl: 'https://github.com/4khil-raj',
      ),
      ProjectModel(
        title: 'Enterprise Cross-Platform Portal',
        description:
            'Responsive web and mobile application featuring stateful authentication, offline-first sync with Hive, and interactive dashboard UI components.',
        technologies: ['Flutter Web', 'Hive', 'Provider', 'Responsive Layout', 'GraphQL'],
        githubUrl: 'https://github.com/4khil-raj',
      ),
    ];
  }
}
