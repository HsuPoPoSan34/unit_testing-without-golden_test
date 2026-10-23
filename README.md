# unit_testing

A Flutter Japanese-learning app with a layered test suite.

## Test layout

```text
test/
  unit/       Pure vocabulary-filter and quiz-answer logic tests
  widget/     Login/navigation and screen interaction tests
  golden/     One golden test file per screen plus shared test helpers
  goldens/    Golden reference PNGs
  mocks/      Repository mock/fake location when data sources are added
integration_test/
  app_flow_test.dart
```

The current app implements login navigation, Home, Vocabulary, Kanji, Grammar,
and Quiz. Signup, Profile, games, mock exams, search, and repository/API
features are not implemented yet, so they do not have tests. Vocabulary uses
local in-memory data; add repository mocks when an external data source exists.

## Appearance

Choose Light or Dark on the login screen. The selected theme applies to the
whole app and remains active while navigating between screens. It currently
resets to Light when the app is restarted.

## Run tests

Run unit, widget, and golden tests:

```sh
flutter test
```

Run an individual layer:

```sh
flutter test test/unit
flutter test test/widget
flutter test test/golden
```

Run one screen's golden tests:

```sh
flutter test test/golden/vocabulary_screen_test.dart
flutter test test/golden/kanji_screen_test.dart
flutter test test/golden/auth_screen_test.dart
```

Run the end-to-end flow on an available emulator or connected device:

```sh
flutter test integration_test/app_flow_test.dart -d <device-id>
```

List available device IDs with `flutter devices`. The integration flow covers
Login → Home → Vocabulary → Home → Quiz.

Golden tests capture Login, Home, Vocabulary, Kanji, Grammar, and Quiz in both
light and dark themes at phone (375×667) and tablet (800×1280) sizes, comparing
them against PNGs grouped by screen in `test/goldens/` (for example,
`test/goldens/grammar/` and `test/goldens/home/`). Review visual changes and
intentionally update the baselines with:

```sh
flutter test --update-goldens test/golden
```

Noto Sans JP is bundled as the app's Japanese fallback and is loaded explicitly
by golden tests for repeatable screenshots. The golden tests are available in
VS Code's Testing view under `test/golden`.

Mocktail and Faker are not dependencies yet: the app has no repository/API to
mock and its current vocabulary dataset is too small to need generated test
data. Flutter's built-in golden matcher is sufficient for the current screens.
