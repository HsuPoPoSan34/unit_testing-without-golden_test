import 'package:flutter/material.dart';

import '../../widgets/logout_button.dart';

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar'),
        actions: const [LogoutButton()],
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('～たい'),
            subtitle: Text('Want to do'),
          ),
          ListTile(
            title: Text('～ながら'),
            subtitle: Text('While doing'),
          ),
          ListTile(
            title: Text('～ことがある'),
            subtitle: Text('Have done before'),
          ),
        ],
      ),
    );
  }
}