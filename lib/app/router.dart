import 'package:flutter/material.dart';
import '../presentation/features/home/view/home_screen.dart';

/// App route names
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
}

/// App router configuration
///
/// This handles navigation throughout the app.
/// Currently uses a single-page scroll experience, but this
/// structure allows for easy expansion to multi-page navigation.
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }

  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.home: (_) => const HomeScreen(),
      };
}
