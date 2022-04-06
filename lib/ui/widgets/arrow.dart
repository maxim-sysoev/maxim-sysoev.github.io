import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/assets.dart';

class Arrow extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final bool isRotated;

  const Arrow({
    this.width,
    this.height,
    this.color,
    this.isRotated = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isRotated ? 2 : 0,
      child: SvgPicture.asset(
        IconsRes.arrow,
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
