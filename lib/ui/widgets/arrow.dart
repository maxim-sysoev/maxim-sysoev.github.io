import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/assets.dart';

class Arrow extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const Arrow({
    this.width,
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsRes.arrow,
      width: width,
      height: height,
      color: color,
    );
  }
}
