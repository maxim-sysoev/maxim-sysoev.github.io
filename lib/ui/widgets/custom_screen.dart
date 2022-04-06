import 'package:flutter/material.dart';
import 'package:quiz/ui/widgets/background_painter.dart';

class CustomScreen extends StatelessWidget {
  final Widget child;

  const CustomScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
