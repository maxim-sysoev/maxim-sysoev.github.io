import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_wm.dart';
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
          body: Center(
            child: StateNotifierBuilder<ScreenSize>(
              listenableState: wm.screenSize,
              builder: (_, size) =>
              size?.when(
                extraSmall: () => const Text('extraSmall'),
                small: () => const Text('small'),
                medium: () => const Text('medium'),
                large: () => const Text('large'),
                extraLarge: () => const Text('extraLarge'),
              ) ??
                  const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
