import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/ui/screen/result/result_model.dart';
import 'package:quiz/ui/screen/result/result_screen.dart';
import 'package:url_launcher/url_launcher.dart';

/// Ссылка на Telegram-канал Surf Tech
const _url = 'https://t.me/+-wlYDnWfzDQ5YTMy';

ResultWidgetModel createResultWidgetModel(BuildContext context) {
  return ResultWidgetModel();
}

class ResultWidgetModel extends WidgetModel<ResultScreen, ResultModel>
    implements IResultWidgetModel {
  ResultWidgetModel() : super(ResultModel());

  @override
  Future<void> goToTelegram() async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}

abstract class IResultWidgetModel extends IWidgetModel {
  void goToTelegram();
}
