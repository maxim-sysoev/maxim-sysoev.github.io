import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz/assets/colors.dart';

class BackgroundPainter extends CustomPainter {
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
