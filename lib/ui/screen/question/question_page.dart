import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/util/iterable_extension.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/secondary_button.dart';
import 'package:quiz/ui/widgets/selection_card.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Какой объем памяти имела автоматическая цифровая вычислительная машина М-1',
          style: FontsRes.h2Black,
        ),
        const SizedBox(height: 16),
        Text(
          'Выбери один вариант ответа:',
          style: FontsRes.text1Black,
        ),
        const SizedBox(height: 32),
        ...['rmkwksmd', 'asdanj asmda', 'asdjna knjsda', 'askdmaskd']
            .map<Widget>((e) => SelectionCard(text: e, onPressed: () {}))
            .separated(const SizedBox(height: 8)),
        const SizedBox(height: 32),
        PrimaryButton(text: StringRes.nextQuestion, onPressed: () {}),
        const SizedBox(height: 24),
        SecondaryButton(text: StringRes.skipQuestion, onPressed: () {}),
      ],
    );
  }
}
