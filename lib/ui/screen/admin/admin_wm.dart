import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';
import 'package:quiz/ui/screen/admin/admin_model.dart';
import 'package:quiz/ui/screen/admin/admin_screen.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_dialog.dart';

AdminWidgetModel createAdminWidgetModel(BuildContext context) {
  return AdminWidgetModel(Navigator.of(context));
}

class AdminWidgetModel extends WidgetModel<AdminScreen, AdminModel>
    with TickerProviderWidgetModelMixin
    implements IAdminWidgetModel {
  @override
  late final tabController = TabController(length: 2, vsync: this);

  final NavigatorState _navigator;
  late final StreamSubscription _questionsSubscription;
  late final StreamSubscription _resultsSubscription;

  final _questionsState = EntityStateNotifier<List<Question>>();
  final _resultsState = EntityStateNotifier<List<QuizResult>>();

  @override
  ListenableState<EntityState<List<Question>>> get questionsState => _questionsState;

  @override
  ListenableState<EntityState<List<QuizResult>>> get resultsState => _resultsState;

  AdminWidgetModel(this._navigator) : super(AdminModel());

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _questionsSubscription = model.listenQuestions().listen(_questionsState.content);
    _resultsSubscription = model.listenResults().listen(_resultsState.content);
  }

  @override
  void dispose() {
    _questionsSubscription.cancel();
    _resultsSubscription.cancel();
    super.dispose();
  }

  @override
  void deleteQuestion(Question question) {
    // TODO: implement dialog
    model.deleteQuestion(question);
  }

  @override
  void editQuestion(Question question) {
    showDialog<void>(
      context: context,
      builder: (context) => EditQuestionDialog(
        question: question,
      ),
    );
  }

  @override
  void createNewQuestion() {
    showDialog<void>(
      context: context,
      builder: (context) => const EditQuestionDialog(),
    );
  }

  @override
  void exportResponses(List<QuizResult> result) {
    model.exportFile(result, _questionsState.value!.data!);
  }

  @override
  void onBack() {
    _navigator.pop();
  }
}

abstract class IAdminWidgetModel extends IWidgetModel {
  TabController get tabController;

  ListenableState<EntityState<List<Question>>> get questionsState;

  ListenableState<EntityState<List<QuizResult>>> get resultsState;

  void deleteQuestion(Question question);

  void editQuestion(Question question);

  void createNewQuestion();

  void exportResponses(List<QuizResult> result);

  void onBack();
}
