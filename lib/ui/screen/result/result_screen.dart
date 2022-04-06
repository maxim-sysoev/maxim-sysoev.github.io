import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/home_route.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

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
            RichText(
              text: const TextSpan(
                style: FontsRes.h1Black,
                children: [
                  TextSpan(text: StringRes.resultHeader1),
                  TextSpan(text: StringRes.resultHeader2, style: FontsRes.h1BlueItalic),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(StringRes.resultDescription, style: FontsRes.text1Black),
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
