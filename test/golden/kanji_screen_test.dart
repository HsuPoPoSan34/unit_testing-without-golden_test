import 'package:unit_testing/features/kanji/kanji_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(folder: 'kanji', buildScreen: (_) => const KanjiScreen());
}
