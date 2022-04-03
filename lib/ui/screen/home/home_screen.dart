import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_wm.dart';
import 'package:quiz/ui/screen/home/layouts/medium.dart';
import 'package:quiz/ui/screen/home/layouts/small.dart';
import 'package:quiz/ui/util/screen_util.dart';

/// Quiz home screen
class HomeScreen extends ElementaryWidget<HomeWidgetModel> {
  const HomeScreen({
    Key? key,
    WidgetModelFactory factory = createHomeWidgetModel,
  }) : super(factory, key: key);

  @override
  Widget build(IHomeWidgetModel wm) {
    return LayoutBuilder(
      builder: (_, size) {
        wm.onResize();
        return Scaffold(
          backgroundColor: Colors.white,
          body: StateNotifierBuilder<ScreenSize>(
            listenableState: wm.screenSizeState,
            builder: (_, size) =>
                size?.maybeWhen(
                  orElse: () => HomeMediumLayout(onStartQuiz: wm.onStartQuiz),
                  extraSmall: () => HomeSmallLayout(onStartQuiz: wm.onStartQuiz),
                  small: () => HomeSmallLayout(onStartQuiz: wm.onStartQuiz),
                  // medium: () => const Text('medium'),
                  // large: () => const Text('large'),
                  // extraLarge: () => const Text('extraLarge'),
                ) ??
                const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
