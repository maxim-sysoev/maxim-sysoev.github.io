import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/home/home_model.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';
import 'package:quiz/ui/screen/question/question_route.dart';

HomeWidgetModel createHomeWidgetModel(BuildContext context) {
  return HomeWidgetModel(Navigator.of(context));
}

class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel> implements IHomeWidgetModel {
  final NavigatorState _navigator;

  Iterable<Question>? _questions;

  HomeWidgetModel(this._navigator) : super(HomeModel());

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadQuestions().then((value) => _questions = value);
  }

  @override
  void onStartQuiz() {
    final questions = _questions;
    if (questions == null) return;
    _navigator.push(QuestionRoute(questions));
  }
}

abstract class IHomeWidgetModel extends IWidgetModel {
  void onStartQuiz();
}
