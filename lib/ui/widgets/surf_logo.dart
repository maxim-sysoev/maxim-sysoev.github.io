import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/assets.dart';

class SurfLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const SurfLogo({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsRes.surf,
      width: width,
      height: height,
    );
  }
}
