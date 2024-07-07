import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String? activeScreen;
  final List<String> selectedAnswers = [];

  /// state constructor
  /// initState(): Executed by Flutter when the StatefulWidget's State object is initialized
  /// build(): Executed by Flutter when the Widget is built for the first time AND after setState() was called
  /// dispose(): Executed by Flutter right before the Widget will be deleted (e.g., because it was displayed conditionally)

  @override
  void initState() {
    activeScreen = 'start-screen';
    super.initState();
  }

  void switchScreen(String screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void onAnswerSelected(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    switch (activeScreen) {
      case 'start-screen':
        screenWidget = StartScreen(onPressed: () => switchScreen('question-screen'));
        break;
      case 'question-screen':
        screenWidget = QuestionScreen(onAnswerSelected: onAnswerSelected);
        break;
      case 'result-screen':
        screenWidget = ResultScreen(selectedAnswers: selectedAnswers, onPressed: () {
          selectedAnswers.clear();
          switchScreen('start-screen');
        });
      default:
        screenWidget = StartScreen(onPressed: () => switchScreen('question-screen'));
    }

    return MaterialApp(
      home: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: screenWidget)),
    );
  }
}
