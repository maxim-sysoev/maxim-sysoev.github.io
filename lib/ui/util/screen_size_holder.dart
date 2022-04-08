import 'package:quiz/ui/util/screen_util.dart';

class ScreenSizeHolder {
  static late ScreenSize _screenSize;

  static ScreenSizeHolder? _i;

  static ScreenSize get screenSize => _screenSize;

  factory ScreenSizeHolder() => _i ??= ScreenSizeHolder._();

  ScreenSizeHolder._();

  static void init() {
    _screenSize = ScreenUtil.screenSize();
  }

  static void update() {
    final newSize = ScreenUtil.screenSize();
    if (newSize == _screenSize) return;
    _screenSize = newSize;
  }
}
