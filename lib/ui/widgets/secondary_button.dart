import 'package:flutter/material.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/widgets/arrow.dart';

class SecondaryButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool withArrow;

  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.withArrow = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHighlightChanged: (state) => setState(() => _isPressed = state),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (widget.withArrow) ...[
              AnimatedCrossFade(
                firstChild: const Arrow(isRotated: true),
                secondChild: const Arrow(isRotated: true, color: ColorRes.black60),
                crossFadeState: _isPressed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: kThemeChangeDuration,
              ),
              const SizedBox(width: 16),
            ],
            AnimatedDefaultTextStyle(
              duration: kThemeChangeDuration,
              style: (_isPressed ? FontsRes.buttonBlack : FontsRes.buttonBlack60)
                  .copyWith(fontStyle: widget.withArrow ? null : FontStyle.italic),
              child: Text(widget.text),
            ),
          ],
        ),
      ),
    );
  }
}
