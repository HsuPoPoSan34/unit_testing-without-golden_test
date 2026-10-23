class VocabularyEntry {
  const VocabularyEntry({
    required this.word,
    required this.meaning,
    required this.level,
  });

  final String word;
  final String meaning;
  final String level;
}

const vocabularyEntries = [
  VocabularyEntry(word: '犬', meaning: 'Dog', level: 'N5'),
  VocabularyEntry(word: '猫', meaning: 'Cat', level: 'N5'),
  VocabularyEntry(word: '経験', meaning: 'Experience', level: 'N3'),
];

List<VocabularyEntry> filterVocabularyByLevel(
  Iterable<VocabularyEntry> entries,
  String level,
) {
  if (level == 'All') {
    return entries.toList();
  }

  return entries.where((entry) => entry.level == level).toList();
}
