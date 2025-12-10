import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom BlocObserver for logging and debugging Bloc events
///
/// This observer monitors all Bloc/Cubit events across the app:
/// - onCreate: Called when a new Bloc/Cubit is created
/// - onChange: Called whenever state changes occur
/// - onError: Called when errors occur in Blocs/Cubits
/// - onClose: Called when a Bloc/Cubit is closed
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    // Log bloc creation for debugging
    // print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // Log state changes for debugging
    // print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // Log errors for debugging
    // print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    // Log bloc closure for debugging
    // print('onClose -- ${bloc.runtimeType}');
  }
}
