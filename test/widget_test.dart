import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:akhil_raj_portfolio/app/app.dart';

class MockStorage implements Storage {
  final Map<String, dynamic> _storage = {};

  @override
  dynamic read(String key) => _storage[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  late Storage storage;

  setUp(() {
    storage = MockStorage();
    HydratedBloc.storage = storage;
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining('AKHIL RAJ', findRichText: true), findsWidgets);
  });
}
