import 'package:flutter/material.dart';

import '../../widgets/logout_button.dart';

class KanjiScreen extends StatelessWidget {
  const KanjiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kanjis = [
      ['日', 'Sun'],
      ['月', 'Moon'],
      ['火', 'Fire'],
      ['水', 'Water'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanji'),
        actions: const [LogoutButton()],
      ),
      body: ListView.builder(
        itemCount: kanjis.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              kanjis[index][0],
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            subtitle: Text(
              kanjis[index][1],
            ),
          );
        },
      ),
    );
  }
}