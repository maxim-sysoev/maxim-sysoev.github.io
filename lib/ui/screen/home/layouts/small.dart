import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/widgets/quiz_header.dart';
import 'package:quiz/ui/screen/home/widgets/start_quiz_button.dart';
import 'package:quiz/ui/screen/home/widgets/surf_logo.dart';

/// HomeScreen small layout UI
class HomeSmallLayout extends StatelessWidget {
  final VoidCallback onStartQuiz;

  const HomeSmallLayout({required this.onStartQuiz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              children: [
                const Spacer(),
                const SurfLogo(height: 200),
                const Spacer(),
                const QuizHeader(textAlign: TextAlign.center),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: StartQuizButton(onPressed: onStartQuiz, style: FontsRes.regular30White),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
