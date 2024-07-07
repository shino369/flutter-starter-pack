import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.type,
  });

  final void Function() onPressed;
  final String? type;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        backgroundColor: const Color.fromARGB(255, 76, 135, 239),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      child: child,
    );
  }
}

class Answer extends StatelessWidget {
  const Answer(this.answer, {super.key, required this.onPressed});

  final String answer;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return StyledButton(
      onPressed: onPressed,
      child: Text(answer, textAlign: TextAlign.center,),
    );
  }
}
