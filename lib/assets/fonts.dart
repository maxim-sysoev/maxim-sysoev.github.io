import 'package:flutter/material.dart';

const _steinbeck = 'steinbeck';

class FontsRes {
  static const TextStyle steinbeck = TextStyle(fontFamily: _steinbeck);
  static const TextStyle regular40Black = TextStyle(fontFamily: _steinbeck, fontSize: 40);
  static const TextStyle regular20Black = TextStyle(fontFamily: _steinbeck, fontSize: 20);
  static const TextStyle regular20White = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 20,
    color: Colors.white,
  );

  static const TextStyle regular30White = TextStyle(
    fontFamily: _steinbeck,
    fontSize: 30,
    color: Colors.white,
  );

  const FontsRes._();
}
