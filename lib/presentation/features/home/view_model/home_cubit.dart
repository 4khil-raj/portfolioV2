import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/profile_model.dart';
import '../../../../data/models/experience_model.dart';
import '../../../../data/models/education_model.dart';
import '../../../../data/models/skill_model.dart';
import '../../../../data/repositories/profile_repository.dart';

/// Home state containing all portfolio data
///
/// This state class holds all the data needed for the home screen,
/// including profile info, experiences, education, and skills.
class HomeState {
  final ProfileModel profile;
  final List<ExperienceModel> experiences;
  final List<EducationModel> education;
  final List<SkillCategoryModel> skillCategories;
  final List<SkillModel> mainSkills;
  final bool isLoading;

  const HomeState({
    required this.profile,
    required this.experiences,
    required this.education,
    required this.skillCategories,
    required this.mainSkills,
    this.isLoading = false,
  });

  HomeState copyWith({
    ProfileModel? profile,
    List<ExperienceModel>? experiences,
    List<EducationModel>? education,
    List<SkillCategoryModel>? skillCategories,
    List<SkillModel>? mainSkills,
    bool? isLoading,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
      skillCategories: skillCategories ?? this.skillCategories,
      mainSkills: mainSkills ?? this.mainSkills,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// HomeCubit acts as the ViewModel in MVVM architecture.
///
/// It manages the state for the home screen by:
/// - Loading data from ProfileRepository
/// - Exposing ProfileModel, ExperienceModel, EducationModel, and SkillModels
/// - No async work needed since data is hardcoded in the repository
///
/// Usage in View:
/// ```dart
/// BlocProvider(
///   create: (_) => HomeCubit(ProfileRepositoryImpl()),
///   child: HomeScreen(),
/// )
/// ```
class HomeCubit extends Cubit<HomeState> {
  final ProfileRepository _repository;

  HomeCubit(this._repository)
      : super(HomeState(
          profile: _repository.getProfile(),
          experiences: _repository.getExperiences(),
          education: _repository.getEducation(),
          skillCategories: _repository.getSkillCategories(),
          mainSkills: _repository.getMainSkills(),
        ));

  /// Refreshes all portfolio data from repository
  void refresh() {
    emit(state.copyWith(isLoading: true));
    emit(HomeState(
      profile: _repository.getProfile(),
      experiences: _repository.getExperiences(),
      education: _repository.getEducation(),
      skillCategories: _repository.getSkillCategories(),
      mainSkills: _repository.getMainSkills(),
      isLoading: false,
    ));
  }
}
