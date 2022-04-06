import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/widgets/arrow.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHighlightChanged: (state) => setState(() => _isPressed = state),
      highlightColor: Colors.black,
      splashColor: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all()),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                AnimatedDefaultTextStyle(
                  duration: kThemeChangeDuration,
                  style: _isPressed ? FontsRes.buttonWhite : FontsRes.buttonBlack,
                  child: Text(widget.text),
                ),
                const SizedBox(width: 16),
                AnimatedCrossFade(
                  firstChild: const Arrow(color: ColorRes.white),
                  secondChild: const Arrow(),
                  crossFadeState: _isPressed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: kThemeChangeDuration,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
