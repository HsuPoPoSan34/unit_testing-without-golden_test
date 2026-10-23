import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:unit_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login, open vocabulary, and answer a quiz', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('email')),
      'learner@example.com',
    );
    await tester.enterText(find.byKey(const Key('password')), 'password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Japanese Learning Home'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Vocabulary'));
    await tester.pumpAndSettle();
    expect(find.text('犬'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Quiz'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Dog'));
    await tester.pumpAndSettle();
    expect(find.text('Correct'), findsOneWidget);
  });
}
