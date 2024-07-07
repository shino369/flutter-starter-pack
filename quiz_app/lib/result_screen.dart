import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/question_summary.dart';
import 'package:quiz_app/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.selectedAnswers,
    required this.onPressed,
  });

  final void Function() onPressed;

  final List<String> selectedAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    selectedAnswers.asMap().forEach((i, answer) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': answer,
      });
    });

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final correctCount = summaryData
        .where(
          (data) => data['correct_answer'] == data['user_answer'],
        )
        .length;

    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered $correctCount out of ${questions.length} correct!',
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 40,
            ),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 40,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white
              ),
              icon: const Icon(Icons.refresh_outlined),
              onPressed: onPressed,
              label: const Text('restart quiz'),
            )
          ],
        ),
      ),
    );
  }
}
