import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/ui/screen/admin/admin_route.dart';
import 'package:quiz/ui/screen/home/home_model.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';
import 'package:quiz/ui/screen/question/question_route.dart';

HomeWidgetModel createHomeWidgetModel(BuildContext context) {
  return HomeWidgetModel(Navigator.of(context));
}

class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel> implements IHomeWidgetModel {
  final NavigatorState _navigator;

  HomeWidgetModel(this._navigator) : super(HomeModel());

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadQuestions();
  }

  @override
  Future<void> onStartQuiz() async {
    final questions = await model.selectQuestions();
    if (questions == null) return;
    unawaited(_navigator.push(QuestionRoute(questions)));
  }

  @override
  void openAdminPanel() {
    if (!kDebugMode) return;
    _navigator.push(AdminRoute());
  }
}

abstract class IHomeWidgetModel extends IWidgetModel {
  void onStartQuiz();

  void openAdminPanel();
}
