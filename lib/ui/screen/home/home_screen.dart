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
            GestureDetector(
              onTap: wm.openAdminPanel,
              child: const SurfLogo(width: 60),
            ),
            const Spacer(),
            const Text(
              StringRes.quizHeader,
              style: FontsRes.h1Black,
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
