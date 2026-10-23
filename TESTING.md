# Testing workflow

This project uses Flutter's built-in test tools. Run tests from the project
root, where `pubspec.yaml` is located.

## Test phases

Run the phases in this order when validating a change:

1. **Static analysis** catches type errors, unused code, and lint issues before
   tests run.
2. **Unit tests** validate pure logic without building widgets or starting the
   app.
3. **Widget tests** validate screen behavior and navigation in Flutter's test
   environment.
4. **Golden tests** render screens and compare the resulting images with
   checked-in screenshots.
5. **Integration tests** exercise an end-to-end flow on an emulator or device.
6. **Full suite** runs all tests together before completing a broad change.

For a small change, run the narrowest relevant test first. Run analysis and the
full suite when the change affects shared behavior or multiple screens.

## Commands

Run static analysis:

```powershell
flutter analyze
```

Run all unit tests:

```powershell
flutter test test\unit
```

Run all widget tests:

```powershell
flutter test test\widget
```

Run all golden screenshot tests:

```powershell
flutter test test\golden
```

Run golden tests for one screen:

```powershell
flutter test test\golden\auth_screen_test.dart
flutter test test\golden\home_screen_test.dart
flutter test test\golden\vocabulary_screen_test.dart
flutter test test\golden\kanji_screen_test.dart
flutter test test\golden\grammar_screen_test.dart
flutter test test\golden\quiz_screen_test.dart
```

Run all tests:

```powershell
flutter test
```

Run the end-to-end app flow on a device:

```powershell
flutter devices
flutter test integration_test\app_flow_test.dart -d <device-id>
```

Replace `<device-id>` with an ID listed by `flutter devices`. Integration tests
need an available emulator or connected device.

## Screen golden tests

Each screen has a separate test file under `test\golden`. For example,
`vocabulary_screen_test.dart` is responsible for Vocabulary screenshots and
`kanji_screen_test.dart` is responsible for Kanji screenshots. `auth_screen_test.dart`
covers the login screen. Shared setup and the phone/tablet and light/dark test
matrix are implemented in `golden_test_helpers.dart`.

Each screen is captured in these configurations:

| Viewport | Logical size | Themes |
| --- | --- | --- |
| Phone | 375 × 667 | Light and dark |
| Tablet | 800 × 1280 | Light and dark |

Golden references are stored by screen in `test\goldens`. The `login` folder
contains screenshots for the auth/login screen. For example:

```text
test\goldens\
  grammar\
  home\
  kanji\
  login\
  quiz\
  vocabulary\
```

When intentionally changing a screen's appearance, regenerate the reference
images with:

```powershell
flutter test --update-goldens test\golden
```

Regeneration updates the references; it does not review them. Inspect the
changed PNGs to confirm the visual differences are expected, then run the
golden tests normally to verify that the new references match:

```powershell
flutter test test\golden
```

If a golden test fails, compare the actual and expected images reported by the
test runner. Check for unintended layout changes, theme differences, font
loading issues, and viewport-size changes before updating any reference.

## Adding a screen test

1. Create a dedicated file such as `test\golden\profile_screen_test.dart`.
2. Import the screen widget and `golden_test_helpers.dart`.
3. Call `testScreenGoldens` with a unique screenshot folder name and a builder
   for the screen. The builder receives the theme mode for the current test.
4. Generate initial screenshots with
   `flutter test --update-goldens test\golden`.
5. Review the generated images in `test\goldens\<screen-folder>`.
6. Run that screen's test file and then the full golden test directory.

Example:

```dart
import 'package:unit_testing/features/profile/profile_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'profile',
    buildScreen: (_) => const ProfileScreen(),
  );
}
```

## VS Code test tools

The Flutter and Dart extensions discover tests in the Testing view. Select an
individual test to run or debug it, or use the Testing view to run the suite.
The terminal commands above are useful for repeatable validation and CI.
