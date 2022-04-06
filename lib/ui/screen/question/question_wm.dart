import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/question/question_model.dart';
import 'package:quiz/ui/screen/question/question_screen.dart';
import 'package:quiz/ui/screen/result/result_route.dart';

const _kChangePageDuration = Duration(milliseconds: 400);
const _kChangePageCurve = Curves.easeInOutQuad;

QuestionWidgetModel createQuestionWidgetModel({
  required Iterable<Question> questions,
  required BuildContext context,
}) {
  final questionsList = questions.toList()..shuffle();
  final lastQuestions = questionsList.where((e) => !e.canSkip);
  return QuestionWidgetModel(
    questions: [...questionsList.where((e) => e.canSkip), ...lastQuestions],
    navigator: Navigator.of(context),
  );
}

class QuestionWidgetModel extends WidgetModel<QuestionScreen, QuestionModel>
    implements IQuestionWidgetModel {
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
    required List<Question> questions,
    required NavigatorState navigator,
  })  : _totalPages = questions.length,
        _navigator = navigator,
        _questionsState = StateNotifier<List<Question>>(initValue: questions),
        super(QuestionModel());

  @override
  void nextQuestion() {
    final isStepPerformed = _changedNextPage();
    if (isStepPerformed) return;
    model.saveResult(_questionsState.value!);
    Future.delayed(const Duration(milliseconds: 50), () => _navigator.push(ResultRoute()));
  }

  @override
  void skipQuestion() {
    _changedNextPage();
  }

  @override
  void onBack() {
    final currPage = _pageState.value!;
    FocusManager.instance.primaryFocus?.unfocus();
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

  @override
  void onScreen() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  bool _changedNextPage() {
    final questions = _questionsState.value!;
    final currPage = _pageState.value!;
    FocusManager.instance.primaryFocus?.unfocus();
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

  void onScreen();
}
