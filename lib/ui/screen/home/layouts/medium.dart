import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/widgets/quiz_header.dart';
import 'package:quiz/ui/screen/home/widgets/start_quiz_button.dart';
import 'package:quiz/ui/screen/home/widgets/surf_logo.dart';

/// HomeScreen medium layout UI
class HomeMediumLayout extends StatelessWidget {
  final VoidCallback onStartQuiz;

  const HomeMediumLayout({
    required this.onStartQuiz,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 90),
              child: SurfLogo(height: 230),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const QuizHeader(),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: double.infinity,
                      child: StartQuizButton(
                        onPressed: onStartQuiz,
                        style: FontsRes.regular30White,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
