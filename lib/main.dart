import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';

/// Application entry point
///
/// This file initializes:
/// 1. Flutter bindings
/// 2. HydratedBloc storage for persisting theme preference
/// 3. Bloc observer for debugging
/// 4. System UI overlays
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc storage for persisting state
  // This is used by AppThemeCubit to persist theme preference
  if (kIsWeb) {
    // Use web storage for web platform
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory.web,
    );
  } else {
    // Use file storage for mobile/desktop platforms
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path,
      ),
    );
  }

  // Set up Bloc observer for debugging
  Bloc.observer = AppBlocObserver();

  // Set preferred orientations (only for non-web platforms)
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  // Run the app
  runApp(const App());
}
