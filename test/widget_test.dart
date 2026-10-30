import 'package:flutter_test/flutter_test.dart';
import 'package:tunas_app/main.dart';

void main() {
  testWidgets('TUNAS app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TunasApp());

    // Verify that TUNAS title is present.
    expect(find.text('TUNAS'), findsWidgets);
  });
}
