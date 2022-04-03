import 'package:flutter/widgets.dart';
import 'package:quiz/assets/assets.dart';

class StartQuiz extends StatelessWidget {
  final TextAlign textAlign;

  const StartQuiz({
    this.textAlign = TextAlign.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringRes.quizHomeTitle,
          style: FontsRes.regular40,
          textAlign: textAlign,
        ),
      ],
    );
  }
}
