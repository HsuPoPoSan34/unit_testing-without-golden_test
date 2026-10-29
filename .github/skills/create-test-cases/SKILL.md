---
name: create-test-cases
description: "Use when creating or extending Flutter/Dart test cases in this project. Select the right test layer, follow this repository's test structure and helpers, and validate the focused behavior."
---

# Create Test Cases

Create maintainable tests for implemented behavior in this Flutter Japanese-learning app. Use the existing test organization and conventions; do not assume examples in documentation describe features that currently exist.

## Workflow

1. Read the current `PROJECT_SPEC.md` at the repository root if present, plus the relevant feature code, callers, and tests. Consult `README.md` and the testing guides when useful.
2. Confirm the behavior exists and identify its observable outcomes before writing tests. The guides include hypothetical examples; do not create tests for unimplemented features just because they are mentioned there.
3. Choose the narrowest test layer that verifies the behavior:

   | Test type | Use for | Location |
   | --- | --- | --- |
   | Unit | Pure logic and data transformations, independent of Flutter widgets | `test/unit/<feature>_test.dart` |
   | Widget | Rendering, input, interactions, state changes, and navigation in Flutter's test environment | `test/widget/<feature>_test.dart` |
   | Golden | Intended screen appearance across the established theme and viewport matrix | `test/golden/<screen>_screen_test.dart`; images in `test/goldens/<screen>/` |
   | Integration | A complete user journey through the real app | `integration_test/` |

   A feature may need more than one layer when each test covers a distinct behavior. Do not duplicate the same assertion across layers without a reason.

4. Follow nearby test patterns:
   - Use `package:flutter_test/flutter_test.dart` and the package import prefix `package:unit_testing/...`.
   - Reuse `test/widget/test_helpers.dart` (`setTestView` and `openHome`) for widget tests where appropriate.
   - Reuse `test/golden/golden_test_helpers.dart` and `testScreenGoldens` for screen goldens. The helper covers phone (375 × 667) and tablet (800 × 1280) in light and dark themes.
   - Integration tests should initialize `IntegrationTestWidgetsFlutterBinding`, start the app through `app.main()`, and interact through the user-facing UI. Keep them in `integration_test/`.
   - Prefer stable, descriptive widget keys for controls when existing labels are not reliable selectors. Add a key to production code only when needed for a meaningful test.
   - Reuse existing test data and setup. Do not add a mocking or data-generation package unless the feature needs it and the dependency change is requested or clearly required.

5. Cover the requested behavior with focused scenarios, including relevant boundary or alternate outcomes (for example, matching and non-matching filters, correct and incorrect answers, or navigation and back-navigation). Assert user-visible results or public logic outputs rather than private implementation details.
6. Run the smallest relevant test command from the project root. If Dart code changed, run `flutter analyze` as appropriate. Expand to the full suite when shared behavior or multiple areas changed.

## Current Project Layout

```text
test/
  unit/
  widget/
    test_helpers.dart
  golden/
    golden_test_helpers.dart
  goldens/
  mocks/
integration_test/
  app_flow_test.dart
```

The README currently identifies Login, Home, Vocabulary, Kanji, Grammar, and Quiz as implemented. Check the current source and README before relying on this list. Signup, Profile, games, mock exams, search, and repository/API behavior are described as not implemented in the current README; do not invent test scenarios for them unless the implementation has since changed.

## Commands

Run one test file:

```powershell
flutter test test\unit\vocabulary_filter_test.dart
flutter test test\widget\navigation_and_interaction_test.dart
flutter test test\golden\vocabulary_screen_test.dart
```

Run a test layer or the full test suite:

```powershell
flutter test test\unit
flutter test test\widget
flutter test test\golden
flutter test
```

Run static analysis after Dart changes:

```powershell
flutter analyze
```

Integration tests need an available emulator or connected device:

```powershell
flutter devices
flutter test integration_test\app_flow_test.dart -d <device-id>
```

## Golden Test Care

Only update golden references for an intentional visual change. Run the focused golden test with `--update-goldens`, inspect every generated PNG, then run the test normally to confirm the references. Never treat regenerated images alone as proof that the appearance is correct.

## Completion

Report which test file(s) were added or changed and the exact validation commands run. Distinguish passing checks from checks not run, including device-dependent integration tests.
