import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/profile_model.dart';
import '../../../../data/models/experience_model.dart';
import '../../../../data/models/education_model.dart';
import '../../../../data/models/skill_model.dart';
import '../../../../data/models/project_model.dart';
import '../../../../data/repositories/profile_repository.dart';

/// Home state containing all portfolio data
class HomeState {
  final ProfileModel profile;
  final List<ExperienceModel> experiences;
  final List<EducationModel> education;
  final List<SkillCategoryModel> skillCategories;
  final List<SkillModel> mainSkills;
  final List<ProjectModel> projects;
  final bool isLoading;

  const HomeState({
    required this.profile,
    required this.experiences,
    required this.education,
    required this.skillCategories,
    required this.mainSkills,
    required this.projects,
    this.isLoading = false,
  });

  HomeState copyWith({
    ProfileModel? profile,
    List<ExperienceModel>? experiences,
    List<EducationModel>? education,
    List<SkillCategoryModel>? skillCategories,
    List<SkillModel>? mainSkills,
    List<ProjectModel>? projects,
    bool? isLoading,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
      skillCategories: skillCategories ?? this.skillCategories,
      mainSkills: mainSkills ?? this.mainSkills,
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// HomeCubit acts as the ViewModel in MVVM architecture.
class HomeCubit extends Cubit<HomeState> {
  final ProfileRepository _repository;

  HomeCubit(this._repository)
      : super(HomeState(
          profile: _repository.getProfile(),
          experiences: _repository.getExperiences(),
          education: _repository.getEducation(),
          skillCategories: _repository.getSkillCategories(),
          mainSkills: _repository.getMainSkills(),
          projects: _repository.getProjects(),
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
      projects: _repository.getProjects(),
      isLoading: false,
    ));
  }
}

