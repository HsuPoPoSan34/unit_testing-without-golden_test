import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/features/quiz/quiz_logic.dart';

void main() {
  group('isCorrectQuizAnswer', () {
    test('returns true for the correct answer', () {
      expect(isCorrectQuizAnswer('Dog', correctAnswer: 'Dog'), isTrue);
    });

    test('returns false for an incorrect answer', () {
      expect(isCorrectQuizAnswer('Cat', correctAnswer: 'Dog'), isFalse);
    });
  });
}
