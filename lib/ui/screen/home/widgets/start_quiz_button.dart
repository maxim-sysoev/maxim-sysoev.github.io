import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/widgets/action_button.dart';

class StartQuizButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle style;

  const StartQuizButton({
    required this.onPressed,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      text: StringRes.startQuiz,
      style: style,
      onPressed: onPressed,
    );
  }
}
