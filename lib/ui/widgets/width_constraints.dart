import 'package:flutter/material.dart';

class WidthConstraints extends StatelessWidget {
  final Widget child;

  const WidthConstraints({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: child,
    );
  }
}
