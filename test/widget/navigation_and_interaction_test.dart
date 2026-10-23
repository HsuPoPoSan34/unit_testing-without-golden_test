import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/features/quiz/quiz_screen.dart';
import 'package:unit_testing/features/vocabulary/vocabulary_screen.dart';
import 'package:unit_testing/main.dart';

import 'test_helpers.dart';

void main() {
  group('app navigation', () {
    testWidgets('login navigates to home', (tester) async {
      setTestView(tester);
      await tester.pumpWidget(const MyApp());

      await tester.enterText(
        find.byKey(const Key('email')),
        'learner@example.com',
      );
      await tester.enterText(find.byKey(const Key('password')), 'password');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Japanese Learning Home'), findsOneWidget);
    });

    testWidgets('login appearance setting applies across app navigation', (
      tester,
    ) async {
      setTestView(tester);
      await tester.pumpWidget(const MyApp());

      expect(
        Theme.of(
          tester.element(find.byKey(const Key('theme_mode_selector'))),
        ).brightness,
        Brightness.light,
      );

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(
        Theme.of(
          tester.element(find.byKey(const Key('theme_mode_selector'))),
        ).brightness,
        Brightness.dark,
      );
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );

      await tester.enterText(
        find.byKey(const Key('email')),
        'learner@example.com',
      );
      await tester.enterText(find.byKey(const Key('password')), 'password');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Japanese Learning Home'), findsOneWidget);
      expect(
        Theme.of(
          tester.element(find.text('Japanese Learning Home')),
        ).brightness,
        Brightness.dark,
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Vocabulary'));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.text('Vocabulary'))).brightness,
        Brightness.dark,
      );
    });

    testWidgets('home navigates to each learning screen', (tester) async {
      setTestView(tester);
      await openHome(tester);

      const destinations = {
        'Vocabulary': 'Vocabulary',
        'Kanji': 'Kanji',
        'Grammar': 'Grammar',
        'Quiz': 'Quiz',
      };
      for (final destination in destinations.entries) {
        await tester.tap(find.widgetWithText(ElevatedButton, destination.key));
        await tester.pumpAndSettle();
        expect(find.text(destination.value), findsOneWidget);
        await tester.pageBack();
        await tester.pumpAndSettle();
        expect(find.text('Japanese Learning Home'), findsOneWidget);
      }
    });

    testWidgets('logout from every page returns to login', (tester) async {
      setTestView(tester);

      await openHome(tester);
      await tester.tap(find.byTooltip('Logout'));
      await tester.pumpAndSettle();
      expect(find.text('Japanese Learning'), findsOneWidget);
      expect(find.text('Japanese Learning Home'), findsNothing);

      const destinations = ['Vocabulary', 'Kanji', 'Grammar', 'Quiz'];
      for (final destination in destinations) {
        await openHome(tester);
        await tester.tap(find.widgetWithText(ElevatedButton, destination));
        await tester.pumpAndSettle();

        await tester.tap(find.byTooltip('Logout'));
        await tester.pumpAndSettle();
        expect(find.text('Japanese Learning'), findsOneWidget);
        expect(find.text(destination), findsNothing);
        expect(find.text('Japanese Learning Home'), findsNothing);
      }
    });
  });

  testWidgets('quiz buttons show correct and incorrect feedback', (
    tester,
  ) async {
    setTestView(tester);
    await tester.pumpWidget(const MaterialApp(home: QuizScreen()));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Dog'));
    await tester.pump();
    expect(find.text('Correct'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Cat'));
    await tester.pump();
    expect(find.text('Wrong'), findsOneWidget);
    expect(find.text('Correct'), findsNothing);
  });

  testWidgets('vocabulary dropdown filters DataTable rows', (tester) async {
    setTestView(tester);
    await tester.pumpWidget(const MaterialApp(home: VocabularyScreen()));

    expect(tester.widget<DataTable>(find.byType(DataTable)).rows, hasLength(3));
    expect(find.text('犬'), findsOneWidget);
    expect(find.text('猫'), findsOneWidget);
    expect(find.text('経験'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('N3').last);
    await tester.pumpAndSettle();

    expect(tester.widget<DataTable>(find.byType(DataTable)).rows, hasLength(1));
    expect(find.text('経験'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
    expect(find.text('犬'), findsNothing);
    expect(find.text('猫'), findsNothing);
  });
}
