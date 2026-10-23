import 'package:unit_testing/features/grammar/grammar_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'grammar',
    buildScreen: (_) => const GrammarScreen(),
  );
}
