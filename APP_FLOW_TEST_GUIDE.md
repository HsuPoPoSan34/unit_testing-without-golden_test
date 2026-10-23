# Creating `app_flow_test.dart` for a Japanese Kotoba App

An integration test launches the real Flutter app and checks a user journey
across multiple screens. For a Japanese Kotoba (vocabulary) app, a useful first
flow is:

**Launch → Home → Vocabulary → Find a word → Quiz → Answer**

Use the app's real navigation and widgets. Do not call screen methods directly
or replace the app with a test-only widget.

## 1. Check integration-test setup

In `pubspec.yaml`, make sure `integration_test` is listed under
`dev_dependencies`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

Fetch dependencies if you added it:

```powershell
flutter pub get
```

Create `integration_test/app_flow_test.dart`. The `integration_test` folder
should be at the project root, beside `lib` and `test`.

## 2. Add stable selectors to the app

Prefer `Key`s for important controls and fields. For example, add keys to the
search field and quiz answer buttons:

```dart
TextField(
  key: const Key('vocabulary_search'),
  decoration: const InputDecoration(labelText: 'Search vocabulary'),
)
```

```dart
ElevatedButton(
  key: const Key('answer_dog'),
  onPressed: onPressed,
  child: const Text('犬'),
)
```

Use keys that describe the control, not its current position on the screen.
That makes the test less likely to break when the layout changes.

## 3. Write the flow test

Use this as a starting template. Replace the package name, screen text, keys,
and answer with the values used by your app. If the app does not have login,
omit that part of the journey.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:japanese_kotoba/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('browse Japanese vocabulary and answer a quiz', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // If your app has a sign-in screen, enter test credentials and sign in here.
    // Use a test account or a fake/local authentication service.

    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Vocabulary'));
    await tester.pumpAndSettle();

    final searchField = find.byKey(const Key('vocabulary_search'));
    await tester.enterText(searchField, '犬');
    await tester.pumpAndSettle();
    expect(find.text('犬'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('answer_dog')));
    await tester.pumpAndSettle();
    expect(find.text('Correct'), findsOneWidget);
  });
}
```

The example assumes the app has `Home`, `Vocabulary`, and `Quiz` controls, a
search field keyed `vocabulary_search`, an answer keyed `answer_dog`, and a
visible `Correct` result. Change these to match the app. For instance, if quiz
answers are Japanese words, the correct answer might be `犬` rather than
`Dog`.

The sample assumes the system back action returns from Vocabulary to Home.
Replace it with your app's actual back button or navigation pattern if needed.

## 4. Run it on a device

List available emulators and connected devices:

```powershell
flutter devices
```

Run the flow using a device ID from that list:

```powershell
flutter test integration_test\app_flow_test.dart -d <device-id>
```

## What the test checks

- `IntegrationTestWidgetsFlutterBinding.ensureInitialized()` enables Flutter's
  integration-test binding.
- `app.main()` starts the app entry point.
- `pumpAndSettle()` waits for scheduled frames and animations to finish.
- `find.text(...)` and `find.byKey(...)` locate visible controls or results.
- `tap(...)` and `enterText(...)` perform user-like interactions.
- `expect(...)` verifies that the expected screen or result appeared.

Keep test data predictable. If vocabulary or login depends on a server, use a
test environment, a fake service, or seeded local data; avoid relying on a
production account or network state.
