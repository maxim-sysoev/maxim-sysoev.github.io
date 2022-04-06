import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';

const _steinbeck = 'steinbeck';

class FontsRes {
  static const TextStyle steinbeck = TextStyle(fontFamily: _steinbeck);

  static const TextStyle tabletH1Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 80,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle tabletH1BlueItalic = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 80,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    fontStyle: FontStyle.italic,
    color: ColorRes.blue,
  );

  static const TextStyle tabletH2Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle tabletText1Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  @Deprecated('not used in design')
  static const TextStyle tabletText2Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle h1Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle h2Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle h1BlueItalic = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    fontStyle: FontStyle.italic,
    color: ColorRes.blue,
  );

  static const TextStyle buttonBlack = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle buttonBlack60 = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black60,
  );

  static const TextStyle buttonWhite = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.white,
  );

  static const TextStyle text1Black = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black,
  );

  static const TextStyle text1Black40 = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -.2,
    color: ColorRes.black40,
  );

  const FontsRes._();
}
