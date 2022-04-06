import 'dart:ui';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/home/home_wm.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/surf_logo.dart';

class HomeScreen extends ElementaryWidget<IHomeWidgetModel> {
  const HomeScreen({Key? key}) : super(createHomeWidgetModel, key: key);

  @override
  Widget build(IHomeWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _BackgroundPainter(),
                ),
              ),
              Padding(
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
                    const Text(StringRes.quizDescription, style: FontsRes.text1Black),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      text: StringRes.startQuiz,
                      onPressed: () {},
                    ),
                    const Spacer(),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.blue
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100)
      ..imageFilter = ImageFilter.blur(sigmaX: 100, sigmaY: 100);
    final width = size.width;
    final radius = (width / 2).clamp(200, 400).toDouble();
    canvas.drawCircle(Offset(width, 0), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
