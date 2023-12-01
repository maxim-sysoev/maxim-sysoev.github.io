import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/result/result_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class ResultScreen extends ElementaryWidget<IResultWidgetModel> {
  final int numberCorrectAnswers;

  const ResultScreen(
    this.numberCorrectAnswers, {
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
            // TODO(NKom-17): create other variations of the results
            if (numberCorrectAnswers < 4)
              _ResultDescriptionBlock(
                header: StringRes.failureResultHeader,
                description: StringRes.failureResultDescription,
                goToTelegram: wm.goToTelegram,
              )
            else if (numberCorrectAnswers < 7)
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
            const SizedBox(height: 32),
            PrimaryButton(
              text: StringRes.resultAction,
              onPressed: wm.repeat,
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
        Text(description, style: FontsRes.text1Black),
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorRes.transparent,
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero,
              ),
              onPressed: goToTelegram,
              child: Text(
                StringRes.subscribeToTelegram1,
                style: FontsRes.text1Black.copyWith(
                  decoration: TextDecoration.underline,
                  color: ColorRes.blue,
                ),
              ),
            ),
            const Text(StringRes.subscribeToTelegram2, style: FontsRes.text1Black),
          ],
        ),
      ],
    );
  }
}
