import 'package:flutter/material.dart';

import '../../widgets/logout_button.dart';
import 'vocabulary_data.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  String level = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = filterVocabularyByLevel(vocabularyEntries, level);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        actions: const [LogoutButton()],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: level,
            items: const [
              DropdownMenuItem(value: 'All', child: Text('All')),
              DropdownMenuItem(value: 'N5', child: Text('N5')),
              DropdownMenuItem(value: 'N3', child: Text('N3')),
            ],
            onChanged: (value) {
              setState(() {
                level = value!;
              });
            },
          ),
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Word')),
                DataColumn(label: Text('Meaning')),
                DataColumn(label: Text('JLPT')),
              ],
              rows: filtered
                  .map(
                    (entry) => DataRow(
                      cells: [
                        DataCell(Text(entry.word)),
                        DataCell(Text(entry.meaning)),
                        DataCell(Text(entry.level)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
