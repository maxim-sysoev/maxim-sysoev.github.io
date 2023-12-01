import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/result/result_screen.dart';

class ResultRoute extends MaterialPageRoute<void> {
  ResultRoute(int countCorrectAnswers)
      : super(
          builder: (_) => ResultScreen(countCorrectAnswers),
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}
