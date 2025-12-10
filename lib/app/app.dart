import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_theme_cubit.dart';
import '../data/repositories/profile_repository.dart';
import '../presentation/features/home/view/home_screen.dart';
import '../presentation/features/home/view_model/home_cubit.dart';

/// Main App widget
///
/// This is the root widget of the application. It sets up:
/// - BlocProviders for state management (AppThemeCubit for theming, HomeCubit for data)
/// - Theme configuration with light/dark mode support
/// - Material app with proper theming
///
/// MVVM + Bloc Structure:
/// - AppThemeCubit: Manages app-wide theme state (light/dark mode)
/// - HomeCubit: Acts as ViewModel, managing portfolio data state
/// - Views: HomeScreen and section widgets consume state via BlocBuilder
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Theme Cubit - manages light/dark theme state
        // Uses HydratedBloc to persist theme preference across app restarts
        BlocProvider<AppThemeCubit>(
          create: (_) => AppThemeCubit(),
        ),
        // Home Cubit - acts as ViewModel for the home screen
        // Provides portfolio data (profile, experiences, skills, education)
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(ProfileRepositoryImpl()),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            // Theme configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            // Home screen
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
