import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  bool isAnswerCorrect(Map<String, Object> data) {
    return data['user_answer'] == data['correct_answer'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NumberBadge(
                  ((data['question_index'] as int)),
                  isCorrect: isAnswerCorrect(data),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['user_answer'] as String,
                        style: TextStyle(
                          color: isAnswerCorrect(data)
                              ? const Color.fromARGB(255, 99, 216, 103)
                              : const Color.fromARGB(255, 219, 59, 59),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data['correct_answer'] as String,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 17, 120, 168),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NumberBadge extends StatelessWidget {
  const NumberBadge(this.index, {super.key, required this.isCorrect});

  final int index;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isCorrect
              ? const Color.fromARGB(255, 43, 190, 116)
              : const Color.fromRGBO(234, 137, 137, 1),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        (index + 1).toString(),
        style: GoogleFonts.notoSans(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
