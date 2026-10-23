import 'package:flutter/material.dart';

import '../../widgets/logout_button.dart';
import 'quiz_logic.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: const [LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('犬 means?', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = isCorrectQuizAnswer('Dog', correctAnswer: 'Dog')
                      ? 'Correct'
                      : 'Wrong';
                });
              },
              child: const Text('Dog'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = isCorrectQuizAnswer('Cat', correctAnswer: 'Dog')
                      ? 'Correct'
                      : 'Wrong';
                });
              },
              child: const Text('Cat'),
            ),

            const SizedBox(height: 20),

            Text(result, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
