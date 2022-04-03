import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/icons.dart';

/// Surf logo
class SurfLogo extends StatelessWidget {
  final double? width;

  final double? height;

  const SurfLogo({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsRes.surf,
      width: width, // TODO(arefimenko): rm null aware values???
      height: height, // TODO(arefimenko): rm null aware values???
    );
  }
}
