import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/ui/screen/question/question_model.dart';

const _kChangePageDuration = Duration(milliseconds: 400);
const _kChangePageCurve = Curves.easeInOutQuad;

QuestionWidgetModel createQuestionWidgetModel({
  required Iterable<Question> questions,
  required BuildContext context,
}) =>
    QuestionWidgetModel(
      questions: questions,
      navigator: Navigator.of(context),
    );

class QuestionWidgetModel extends WidgetModel implements IQuestionWidgetModel {
  late final NavigatorState _navigator;
  late final StateNotifier<int> _pageState = StateNotifier<int>(initValue: 1);

  late final PageController _pageController = PageController();

  late final int _totalPages;

  late final StateNotifier<List<Question>> _questionsState;

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<int> get pageState => _pageState;

  @override
  ListenableState<List<Question>> get questionsState => _questionsState;

  @override
  int get totalPages => _totalPages;

  QuestionWidgetModel({
    required Iterable<Question> questions,
    required NavigatorState navigator,
  })  : _totalPages = questions.length,
        _navigator = navigator,
        _questionsState = StateNotifier<List<Question>>(initValue: questions.toList()),
        super(QuestionModel());

  @override
  void nextQuestion() {
    // TODO(arefimenko): save answer result
    final isStepPerformed = _changedNextPage();
  }

  @override
  void skipQuestion() {
    final isStepPerformed = _changedNextPage();
  }

  @override
  void onBack() {
    final currPage = _pageState.value!;
    if (currPage == 1) {
      _navigator.pop();
      return;
    }
    _pageState.accept(currPage - 1);
    _pageController.previousPage(duration: _kChangePageDuration, curve: _kChangePageCurve);
  }

  @override
  void onResultUpdated(Object? result) {
    _questionsState.value![_pageController.page!.toInt()].result = result;
  }

  bool _changedNextPage() {
    final questions = _questionsState.value!;
    final currPage = _pageState.value!;
    if (currPage > questions.length - 1) return false;
    _pageState.accept(currPage + 1);
    _pageController.nextPage(duration: _kChangePageDuration, curve: _kChangePageCurve);
    return true;
  }
}

abstract class IQuestionWidgetModel extends IWidgetModel {
  PageController get pageController;

  ListenableState<int> get pageState;

  ListenableState<List<Question>> get questionsState;

  int get totalPages;

  void onResultUpdated(Object? result);

  void nextQuestion();

  void skipQuestion();

  void onBack();
}
