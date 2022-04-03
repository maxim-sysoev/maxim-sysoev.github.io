import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/widgets/start_quiz.dart';
import 'package:quiz/ui/screen/home/widgets/surf_logo.dart';

/// HomeScreen small layout UI
class HomeSmallLayout extends StatelessWidget {
  const HomeSmallLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: const [
              SurfLogo(height: 200),
              SizedBox(height: 80),
              StartQuiz(textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
