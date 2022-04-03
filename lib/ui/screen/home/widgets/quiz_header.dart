import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';

class QuizHeader extends StatelessWidget {
  final TextAlign textAlign;

  const QuizHeader({
    this.textAlign = TextAlign.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      StringRes.quizHomeTitle,
      style: FontsRes.regular40Black,
      textAlign: textAlign,
    );
  }
}
