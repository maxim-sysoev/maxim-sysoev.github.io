import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/assets.dart';

class Arrow extends StatelessWidget {
  final Color? color;
  final bool isRotated;

  const Arrow({
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
        width: 53,
        height: 22,
        color: color,
      ),
    );
  }
}
