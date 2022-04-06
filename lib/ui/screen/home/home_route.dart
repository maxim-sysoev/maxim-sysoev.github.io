import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';

class HomeRoute extends MaterialPageRoute<void> {
  HomeRoute() : super(builder: (_) => const HomeScreen());

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}
