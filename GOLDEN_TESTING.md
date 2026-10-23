# Golden Testing Guide

Golden tests verify that screen appearance matches approved reference screenshots.

## What should be golden tested?

✅ Screen appearance

- Login page
- Home page
- Vocabulary page
- JLPT page
- Dark mode
- Tablet layout

❌ Business logic

Use Unit Tests.

❌ User interaction

Use Widget Tests.

---

## Example Golden Test

File:

test/golden/review_screen_test.dart

```dart
import 'package:my_app/features/review/review_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'review',
    buildScreen: (_) =>
        const ReviewScreen(),
  );
}
```

---

## Generated Golden Images

```text
test/goldens/review/
  phone_light.png
  phone_dark.png
  tablet_light.png
  tablet_dark.png
```

---

## Generate Initial Goldens

```powershell
flutter test --update-goldens test\golden\review_screen_test.dart
```

---

## Verify Existing Goldens

```powershell
flutter test test\golden\review_screen_test.dart
```

---

## When To Update Goldens

✅ Intentional UI change

- New design
- New spacing
- Font change
- Theme update

❌ Unexpected changes

Always review generated PNG files before committing.

---

## Good Candidates

### Authentication

- Login Screen
- Register Screen

### Learning

- Vocabulary Screen
- Kanji Screen

### Game

- Quiz Screen
- Result Screen

### User

- Profile Screen

---

## Validation Checklist

- Light Theme
- Dark Theme
- Phone Layout
- Tablet Layout
- PNG reviewed manually