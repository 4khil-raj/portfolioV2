import 'package:flutter_test/flutter_test.dart';
import 'package:akhil_raj_portfolio/app/app.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the app renders with the name
    expect(find.text('Akhil Raj'), findsOneWidget);
  });
}
