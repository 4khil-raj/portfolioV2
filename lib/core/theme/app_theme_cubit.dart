import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// AppThemeCubit manages the app's theme state (light/dark mode).
///
/// This cubit extends HydratedCubit to persist theme preference across app restarts.
/// The theme mode is stored in shared storage and automatically restored when the app launches.
///
/// Usage:
/// - Use `toggleTheme()` to switch between light and dark mode
/// - Use `setTheme(ThemeMode mode)` to set a specific theme
/// - Access current theme mode through `state`
class AppThemeCubit extends HydratedCubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.dark);

  /// Toggles between light and dark theme modes.
  /// If current mode is dark, switches to light and vice versa.
  void toggleTheme() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  /// Sets the theme to a specific mode.
  /// [mode] can be ThemeMode.light, ThemeMode.dark, or ThemeMode.system.
  void setTheme(ThemeMode mode) {
    emit(mode);
  }

  /// Returns true if the current theme is dark mode.
  bool get isDarkMode => state == ThemeMode.dark;

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final themeIndex = json['themeMode'] as int?;
    if (themeIndex != null && themeIndex < ThemeMode.values.length) {
      return ThemeMode.values[themeIndex];
    }
    return ThemeMode.dark;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.index};
  }
}
