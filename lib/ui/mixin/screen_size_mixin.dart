import 'package:elementary/elementary.dart';
import 'package:quiz/ui/util/screen_util.dart';

mixin ScreenSizeMixin<W extends ElementaryWidget, M extends ElementaryModel> on WidgetModel<W, M> {
  late final StateNotifier<ScreenSize> screenSizeState =
      StateNotifier<ScreenSize>(initValue: ScreenUtil.screenSize());

  void onResize();
}
