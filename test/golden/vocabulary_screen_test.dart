import 'package:unit_testing/features/vocabulary/vocabulary_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(
    folder: 'vocabulary',
    buildScreen: (_) => const VocabularyScreen(),
  );
}
