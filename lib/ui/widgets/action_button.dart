import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? style;

  const ActionButton({
    required this.text,
    required this.onPressed,
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 10,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(text, style: style ?? FontsRes.regular20White),
    );
  }
}
