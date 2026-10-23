# Widget Testing Guide

Widget tests verify that a screen behaves correctly in Flutter's test environment.

## What should be widget tested?

✅ Widget behavior

- Button taps
- Text input
- Screen rendering
- State updates
- Navigation

❌ Visual appearance regression

Use Golden Tests for that.

---

## Example Widget Test

File:

test/widget/review_screen_test.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows a word and its meaning',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ReviewScreen(),
        ),
      );

      expect(
        find.text('犬'),
        findsOneWidget,
      );

      expect(
        find.text('Dog'),
        findsOneWidget,
      );
    },
  );
}
```

---

## Example Interaction Test

```dart
testWidgets(
  'reveals answer when tapped',
  (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ReviewScreen(),
      ),
    );

    await tester.tap(
      find.byKey(
        const Key('reveal_answer'),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Dog'),
      findsOneWidget,
    );
  },
);
```

---

## Run Widget Tests

```powershell
flutter test test\widget\review_screen_test.dart
```

Run all tests:

```powershell
flutter test
```

---

## Good Candidates

### Login

- Enter email
- Enter password
- Tap login

### Vocabulary

- Search box
- Filter dropdown

### Quiz

- Answer selection
- Next button

### Profile

- Edit button
- Save button

### Home

- Menu navigation

---

## Validation Checklist

- Widget renders successfully
- User interaction works
- State changes correctly
- Navigation works
- No screenshot comparison