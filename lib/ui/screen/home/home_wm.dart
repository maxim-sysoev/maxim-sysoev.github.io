import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/api/data/base/question.dart';
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
  ListenableState<ScreenSize> get screenSizeState => _screenSizeState;

  @override
  ListenableState<List<Question>> get questionsState => _questionsState;

  late StateNotifier<ScreenSize> _screenSizeState;

  late StateNotifier<List<Question>> _questionsState;

  HomeWidgetModel(HomeModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _screenSizeState = StateNotifier<ScreenSize>(initValue: ScreenUtil.screenSize());
    _questionsState = StateNotifier<List<Question>>();
  }

  @override
  void onResize() {
    _screenSizeState.accept(ScreenUtil.screenSize());
  }

  @override
  Future<void> onStartQuiz() async {
    final questions = await model.getQuestions();
    _questionsState.accept(questions);
  }
}

abstract class IHomeWidgetModel extends IWidgetModel {
  ListenableState<ScreenSize> get screenSizeState;

  ListenableState<List<Question>> get questionsState;

  Future<void> onStartQuiz();

  void onResize();
}
