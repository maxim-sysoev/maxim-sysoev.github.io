import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/result/result_screen.dart';

class ResultRoute extends MaterialPageRoute<void> {
  ResultRoute({
    required bool isSuccess,
  }) : super(
          builder: (_) => ResultScreen(
            isSuccess: isSuccess,
          ),
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
