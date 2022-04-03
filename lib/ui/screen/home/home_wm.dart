import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/ui/screen/home/home_model.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';
import 'package:quiz/ui/util/screen_util.dart';

/// Builder for [HomeWidgetModel]
HomeWidgetModel createHomeWidgetModel(BuildContext context) {
  return HomeWidgetModel(HomeModel());
}

/// Widget model for [HomeScreen]
class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel> implements IHomeWidgetModel {
  @override
  ListenableState<ScreenSize> get screenSize => _screenSize;

  late StateNotifier<ScreenSize> _screenSize;

  HomeWidgetModel(HomeModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _screenSize = StateNotifier<ScreenSize>(initValue: ScreenUtil.screenSize());
  }

  @override
  void onResize() {
    _screenSize.accept(ScreenUtil.screenSize());
  }
}

abstract class IHomeWidgetModel extends IWidgetModel {
  ListenableState<ScreenSize> get screenSize;

  void onResize();
}
