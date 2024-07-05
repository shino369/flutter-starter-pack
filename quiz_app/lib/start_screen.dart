import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              'assets/images/quiz-logo.png',
              width: 200,
             color: const Color.fromARGB(95, 255, 255, 255), // fake opacity
            ),
          // Opacity(
          //   opacity: 0.7,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 200,
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Learn flutter the fun way',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 60,
          ),
          OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, // text color
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('click me!'))
        ],
      ),
    );
  }
}
