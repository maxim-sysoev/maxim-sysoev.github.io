import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/home_model.dart';
import 'package:quiz/ui/screen/home/home_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class HomeScreen extends ElementaryWidget<IHomeWidgetModel> {
  const HomeScreen({Key? key}) : super(createHomeWidgetModel, key: key);

  @override
  Widget build(IHomeWidgetModel wm) {
    return CustomScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SurfLogo(width: 60),
            const Spacer(),
            RichText(
              text: const TextSpan(
                style: FontsRes.h1Black,
                children: [
                  TextSpan(text: StringRes.quizHeader1),
                  TextSpan(text: StringRes.quizHeader2, style: FontsRes.h1BlueItalic),
                  TextSpan(text: StringRes.quizHeader3),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              StringRes.quizDescription(questionsCount),
              style: FontsRes.text1Black,
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: StringRes.startQuiz, onPressed: wm.onStartQuiz),
            const Spacer(),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
