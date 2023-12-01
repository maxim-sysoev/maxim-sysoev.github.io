import 'package:elementary/elementary.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/result/result_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class ResultScreen extends ElementaryWidget<IResultWidgetModel> {
  final int countCorrectAnswers;

  const ResultScreen(
    this.countCorrectAnswers, {
    Key? key,
  }) : super(createResultWidgetModel, key: key);

  @override
  Widget build(IResultWidgetModel wm) {
    return CustomScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SurfLogo(width: 60),
            const Spacer(),
            if (countCorrectAnswers < 4)
              _ResultDescriptionBlock(
                header: StringRes.failureResultHeader,
                description: StringRes.failureResultDescription,
                goToTelegram: wm.goToTelegram,
              )
            else if (countCorrectAnswers < 7)
              _ResultDescriptionBlock(
                header: StringRes.middleResultHeader,
                description: StringRes.middleResultDescription,
                goToTelegram: wm.goToTelegram,
              )
            else
              _ResultDescriptionBlock(
                header: StringRes.successResultHeader,
                description: StringRes.successResultDescription,
                goToTelegram: wm.goToTelegram,
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ResultDescriptionBlock extends StatelessWidget {
  final String header;
  final String description;
  final VoidCallback goToTelegram;

  const _ResultDescriptionBlock({
    required this.header,
    required this.description,
    required this.goToTelegram,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header, style: FontsRes.h1Black),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: FontsRes.text1Black,
            children: [
              TextSpan(text: description),
              TextSpan(
                text: StringRes.subscribeToTelegram1,
                style: FontsRes.text1Blue,
                recognizer: TapGestureRecognizer()..onTap = goToTelegram,
              ),
              const TextSpan(text: StringRes.subscribeToTelegram2),
            ],
          ),
        ),
      ],
    );
  }
}
