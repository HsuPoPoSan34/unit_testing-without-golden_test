# Unit Testing Guide

Unit tests verify that a function or class returns the correct result for a given input.

## What should be unit tested?

✅ Business logic

- Quiz score calculation
- Vocabulary filtering
- JLPT level filtering
- Date formatting
- Repository data mapping

❌ UI behavior

- Buttons
- TextFields
- Navigation
- Screen layouts

---

## Example Function

File:

lib/features/review/word_filter.dart

```dart
List<Word> filterWords(
  List<Word> words,
  String query,
) {
  // Implementation
}
```

---

## Example Unit Test

File:

test/unit/word_filter_test.dart

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('filterWords', () {
    test('returns matching Japanese words', () {
      final result = filterWords(sampleWords, '犬');

      expect(
        result.map((word) => word.japanese),
        contains('犬'),
      );
    });

    test('returns all words for empty query', () {
      expect(
        filterWords(sampleWords, ''),
        hasLength(sampleWords.length),
      );
    });

    test('returns empty list when no word matches', () {
      expect(
        filterWords(sampleWords, 'not-a-word'),
        isEmpty,
      );
    });
  });
}
```

---

## Run Unit Tests

```powershell
flutter test test\unit\word_filter_test.dart
```

Run all unit tests:

```powershell
flutter test
```

---

## Good Candidates

### Quiz

```dart
calculateScore()
```

### Vocabulary

```dart
filterWords()
sortWords()
```

### Mock Test

```dart
calculateResult()
```

### Profile

```dart
formatUserName()
```

---

## Validation Checklist

- No UI involved
- Fast execution
- Tests business logic only
- Covers edge cases