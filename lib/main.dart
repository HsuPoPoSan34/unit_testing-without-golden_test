import 'package:flutter/material.dart';

import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/vocabulary/vocabulary_screen.dart';
import '../features/kanji/kanji_screen.dart';
import '../features/grammar/grammar_screen.dart';
import '../features/quiz/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japanese Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamilyFallback: const ['NotoSansJP'],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        fontFamilyFallback: const ['NotoSansJP'],
      ),
      themeMode: _themeMode,

      initialRoute: '/',

      routes: {
        '/': (_) => LoginScreen(
          themeMode: _themeMode,
          onThemeModeChanged: (themeMode) {
            setState(() {
              _themeMode = themeMode;
            });
          },
        ),
        '/home': (_) => const HomeScreen(),
        '/vocabulary': (_) => const VocabularyScreen(),
        '/kanji': (_) => const KanjiScreen(),
        '/grammar': (_) => const GrammarScreen(),
        '/quiz': (_) => const QuizScreen(),
      },
    );
  }
}
