import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/features/vocabulary/vocabulary_data.dart';

void main() {
  group('filterVocabularyByLevel', () {
    test('returns all vocabulary for the All filter', () {
      final result = filterVocabularyByLevel(vocabularyEntries, 'All');

      expect(result, hasLength(3));
      expect(result.map((entry) => entry.word), ['犬', '猫', '経験']);
    });

    test('returns only entries at the selected JLPT level', () {
      final result = filterVocabularyByLevel(vocabularyEntries, 'N5');

      expect(result, hasLength(2));
      expect(result.every((entry) => entry.level == 'N5'), isTrue);
    });

    test('returns an empty list when no entries match', () {
      expect(filterVocabularyByLevel(vocabularyEntries, 'N1'), isEmpty);
    });
  });
}
