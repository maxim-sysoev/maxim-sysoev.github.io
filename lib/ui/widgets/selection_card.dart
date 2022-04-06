import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/assets/assets.dart';

class SelectionCard extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isMultiple;

  const SelectionCard({
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.isMultiple = false,
    Key? key,
  }) : super(key: key);

  @override
  _SelectionCardState createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant SelectionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      _isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isSelected = !_isSelected);
        widget.onPressed();
      },
      child: Row(
        children: [
          AnimatedCrossFade(
            firstChild: _SelectedButton(isMultiple: widget.isMultiple, isActive: true),
            secondChild: _SelectedButton(isMultiple: widget.isMultiple),
            crossFadeState: _isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: kThemeChangeDuration,
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(widget.text, style: FontsRes.text1Black)),
        ],
      ),
    );
  }
}

class _SelectedButton extends StatelessWidget {
  final bool isActive;
  final bool isMultiple;

  const _SelectedButton({
    this.isActive = false,
    this.isMultiple = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: isMultiple ? null : const BorderRadius.all(Radius.circular(16)),
          ),
          child: isMultiple
              ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    IconsRes.tick,
                    color: isActive ? null : Colors.transparent,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(6),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isActive ? ColorRes.blue : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
