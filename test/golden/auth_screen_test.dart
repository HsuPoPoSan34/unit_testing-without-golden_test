import 'package:unit_testing/features/auth/login_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'login',
    buildScreen: (themeMode) =>
        LoginScreen(themeMode: themeMode, onThemeModeChanged: (_) {}),
  );
}
