import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/ui/screen/home/home_route.dart';
import 'package:quiz/ui/screen/result/result_model.dart';
import 'package:quiz/ui/screen/result/result_screen.dart';
import 'package:url_launcher/url_launcher.dart';

ResultWidgetModel createResultWidgetModel(BuildContext context) {
  return ResultWidgetModel(Navigator.of(context));
}

class ResultWidgetModel extends WidgetModel<ResultScreen, ResultModel>
    implements IResultWidgetModel {
  final NavigatorState _navigator;

  ResultWidgetModel(this._navigator) : super(ResultModel());

  @override
  void repeat() {
    _navigator.pushAndRemoveUntil(
      HomeRoute(),
      (r) => r.isFirst,
    );
  }

  @override
  Future<void> goToTelegram() async {
    // TODO(NKom-17): вынести константу
    const url = 'https://t.me/surf_tech';
    if (!await launchUrl(
      Uri.parse(url),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

abstract class IResultWidgetModel extends IWidgetModel {
  void repeat();

  void goToTelegram();
}
