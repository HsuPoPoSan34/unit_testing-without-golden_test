import 'package:flutter/material.dart';

import '../../widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget menuButton(
    BuildContext context,
    String title,
    String route,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Japanese Learning Home'),
        actions: const [LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            menuButton(
              context,
              'Vocabulary',
              '/vocabulary',
            ),
            menuButton(
              context,
              'Kanji',
              '/kanji',
            ),
            menuButton(
              context,
              'Grammar',
              '/grammar',
            ),
            menuButton(
              context,
              'Quiz',
              '/quiz',
            ),
          ],
        ),
      ),
    );
  }
}