import 'package:unit_testing/features/quiz/quiz_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(folder: 'quiz', buildScreen: (_) => const QuizScreen());
}
