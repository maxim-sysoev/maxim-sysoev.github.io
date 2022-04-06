import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/question/question_page.dart';
import 'package:quiz/ui/screen/question/question_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/secondary_button.dart';

class QuestionScreen extends ElementaryWidget<IQuestionWidgetModel> {
  const QuestionScreen({Key? key}) : super(createQuestionWidgetModel, key: key);

  @override
  Widget build(IQuestionWidgetModel wm) {
    return CustomScreen(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SecondaryButton(
            withArrow: true,
            text: StringRes.back,
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          const Text('1 из 5 вопросов', style: FontsRes.text1Black40),
          const SizedBox(height: 16),
          QuestionPage(),
        ],
      ),
    );
  }
}
