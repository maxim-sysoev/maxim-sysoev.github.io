import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/question/question_screen.dart';

class QuestionRoute extends MaterialPageRoute<void> {
  QuestionRoute() : super(builder: (_) => const QuestionScreen());

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}
