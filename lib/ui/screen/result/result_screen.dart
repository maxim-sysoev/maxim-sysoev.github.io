import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/home_route.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class ResultScreen extends StatelessWidget {
  final int numberCorrectAnswers;

  const ResultScreen(
    this.numberCorrectAnswers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SurfLogo(width: 60),
            const Spacer(),
            // TODO(NKom-17): create other variations of the results
            if (numberCorrectAnswers > 1)
              const _ResultDescriptionBlock(
                header1: StringRes.successResultHeader1,
                header2: StringRes.successResultHeader2,
                header3: StringRes.successResultHeader3,
                description: StringRes.successResultDescription,
              )
            else
              const _ResultDescriptionBlock(
                header1: StringRes.failureResultHeader1,
                header2: StringRes.failureResultHeader2,
                header3: StringRes.failureResultHeader3,
                description: StringRes.failureResultDescription,
              ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: StringRes.resultAction,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                HomeRoute(),
                (r) => r.isFirst,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ResultDescriptionBlock extends StatelessWidget {
  final String header1;
  final String header2;
  final String header3;
  final String description;

  const _ResultDescriptionBlock({
    required this.header1,
    required this.header2,
    required this.header3,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: FontsRes.h1Black,
            children: [
              TextSpan(text: header1),
              TextSpan(text: header2, style: FontsRes.h1BlueItalic),
              TextSpan(text: header3),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(description, style: FontsRes.text1Black),
      ],
    );
  }
}
