import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/question/question_screen.dart';

class QuestionRoute extends MaterialPageRoute<void> {
  QuestionRoute(Iterable<Question> questions) : super(builder: (_) => QuestionScreen(questions));

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}
