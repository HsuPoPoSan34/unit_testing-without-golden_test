# Testing a New Screen or Feature

This guide shows how to add unit, widget, and golden tests for another page,
screen, or piece of logic in this Japanese Kotoba learning app. The examples
use a hypothetical `ReviewScreen` and a pure `filterWords` function. Replace
their names, paths, labels, and expected results with the ones in your feature.

## Which test should I write?

| Test type | What it verifies | Needs a device? |
| --- | --- | --- |
| Unit | A function or class returns the right result for given inputs | No |
| Widget | A widget displays content and responds to user interaction | No |
| Golden | A rendered screen matches an approved reference image | No |
| Integration | A real user flow across app screens works end-to-end | Usually |

One feature may need several types. For example, test vocabulary filtering as a
unit, its dropdown interaction as a widget test, and the vocabulary page's
appearance as a golden test.

## 1. Add a unit test for logic

Keep logic that can be tested without rendering UI in a Dart function or class.
For example, a word filter could be defined in
`lib/features/review/word_filter.dart`:

```dart
List<Word> filterWords(List<Word> words, String query) {
  // Implement filtering for your app's Word model.
}
```

Create `test/unit/word_filter_test.dart` and test expected behavior, including
important edge cases:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/features/review/word_filter.dart';
import 'package:unit_testing/features/review/word.dart';

void main() {
  group('filterWords', () {
    test('returns matching Japanese words', () {
      final result = filterWords(sampleWords, '犬');

      expect(result.map((word) => word.japanese), contains('犬'));
    });

    test('returns all words for an empty query', () {
      expect(filterWords(sampleWords, ''), hasLength(sampleWords.length));
    });

    test('returns no results when nothing matches', () {
      expect(filterWords(sampleWords, 'not-a-word'), isEmpty);
    });
  });
}
```

This is a pattern, not copy-ready code: define `Word` and `sampleWords`, and
adjust the properties and expected results to your implementation. Avoid
testing Flutter layout in a unit test; use a widget test for that.

Run one unit-test file:

```powershell
flutter test test\unit\word_filter_test.dart
```

## 2. Add a widget test for behavior

Widget tests pump a widget in Flutter's test environment, perform interactions,
and assert what is visible. Create `test/widget/review_screen_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/features/review/review_screen.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('shows a word and its meaning', (tester) async {
    setTestView(tester);
    await tester.pumpWidget(
      const MaterialApp(home: ReviewScreen()),
    );

    expect(find.text('犬'), findsOneWidget);
    expect(find.text('Dog'), findsOneWidget);
  });

  testWidgets('reveals the answer when tapped', (tester) async {
    setTestView(tester);
    await tester.pumpWidget(
      const MaterialApp(home: ReviewScreen()),
    );

    await tester.tap(find.byKey(const Key('reveal_answer')));
    await tester.pumpAndSettle();

    expect(find.text('Dog'), findsOneWidget);
  });
}
```

Change the text, key, and interactions to match your screen. Add stable keys
such as `const Key('reveal_answer')` to important controls when locating them
by displayed text would be fragile. `test/widget/test_helpers.dart` already
provides `setTestView` for a consistent phone-sized viewport.

Run one widget-test file:

```powershell
flutter test test\widget\review_screen_test.dart
```

## 3. Add a golden test for appearance

Golden tests compare a rendered screenshot with a checked-in PNG. The shared
`test/golden/golden_test_helpers.dart` already captures each screen at phone
and tablet sizes, in light and dark themes, and loads the Japanese font.

Create `test/golden/review_screen_test.dart`:

```dart
import 'package:unit_testing/features/review/review_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'review',
    buildScreen: (_) => const ReviewScreen(),
  );
}
```

Use a unique folder name and make sure the screen can render in the helper's
`MaterialApp`. The helper will look for references in:

```text
test/goldens/review/phone_light.png
test/goldens/review/phone_dark.png
test/goldens/review/tablet_light.png
test/goldens/review/tablet_dark.png
```

Generate the initial images:

```powershell
flutter test --update-goldens test\golden\review_screen_test.dart
```

Inspect all generated PNGs to confirm they show the intended layout and
content. Then verify them without update mode:

```powershell
flutter test test\golden\review_screen_test.dart
```

Only regenerate references when the visual change is intentional. Updating
goldens without reviewing the images can accidentally approve a regression.

## 4. Add the screen to navigation tests when needed

If users reach the new screen from Home or another page, add a widget test in
`test/widget/navigation_and_interaction_test.dart` (or a focused test file).
Check both that tapping the destination opens the correct screen and that
back-navigation returns to the expected page. Follow the existing test
patterns and helpers rather than duplicating app setup.

## Suggested test file layout

```text
test/
  unit/
    word_filter_test.dart
  widget/
    review_screen_test.dart
  golden/
    review_screen_test.dart
    golden_test_helpers.dart
  goldens/
    review/
      phone_light.png
      phone_dark.png
      tablet_light.png
      tablet_dark.png
```

## Validate the feature

Run the smallest relevant test first, then broader checks if shared behavior
changed:

```powershell
flutter test test\unit\word_filter_test.dart
flutter test test\widget\review_screen_test.dart
flutter test test\golden\review_screen_test.dart
flutter analyze
```

Run all tests when the feature affects multiple areas:

```powershell
flutter test
```
