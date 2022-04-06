import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/ui/screen/home/home_model.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';

HomeWidgetModel createHomeWidgetModel(BuildContext context) {
  return HomeWidgetModel(HomeModel());
}

class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel> implements IHomeWidgetModel {
  HomeWidgetModel(HomeModel model) : super(model);
}

abstract class IHomeWidgetModel extends IWidgetModel {}
