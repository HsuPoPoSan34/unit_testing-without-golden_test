# Integration Testing Guide

Integration tests verify that multiple screens, services, and features work together in a real user flow.

## What should be integration tested?

✅ Complete user journeys

- Login → Home
- Home → Vocabulary
- Home → Quiz
- Quiz → Result
- Logout

---

## Integration Test Setup

File:

integration_test/app_test.dart

```dart
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding
      .ensureInitialized();
}
```

---

## Example Integration Test

```dart
testWidgets(
  'user can login and open quiz',
  (tester) async {
    await tester.pumpWidget(
      const MyApp(),
    );

    await tester.enterText(
      find.byKey(
        const Key('email'),
      ),
      'user@test.com',
    );

    await tester.enterText(
      find.byKey(
        const Key('password'),
      ),
      'password123',
    );

    await tester.tap(
      find.text('Login'),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Home'),
      findsOneWidget,
    );

    await tester.tap(
      find.text('Quiz'),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Question 1'),
      findsOneWidget,
    );
  },
);
```

---

## Run Integration Tests

Android Emulator:

```powershell
flutter test integration_test
```

or

```powershell
flutter drive ^
  --driver=test_driver/integration_test.dart ^
  --target=integration_test/app_test.dart
```

---

## Recommended Flows for This Project

### Authentication

```text
Login
 → Home
 → Logout
```

### Vocabulary

```text
Login
 → Vocabulary
 → Search
 → Detail
```

### Quiz

```text
Login
 → Quiz
 → Answer Questions
 → Result Screen
```

### JLPT Mock Test

```text
Login
 → Mock Test
 → Finish Exam
 → Score Screen
```

### Profile

```text
Login
 → Profile
 → Update Information
 → Save
```

---

## Validation Checklist

- Real navigation works
- API communication works
- Screens work together
- User flows complete successfully
- App behaves correctly on a device/emulator