import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/admin/admin_model.dart';
import 'package:quiz/ui/screen/admin/admin_screen.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_dialog.dart';

AdminWidgetModel createAdminWidgetModel(BuildContext context) {
  return AdminWidgetModel(Navigator.of(context));
}

class AdminWidgetModel extends WidgetModel<AdminScreen, AdminModel> implements IAdminWidgetModel {
  final NavigatorState _navigator;
  late final StreamSubscription _subscription;

  final _questionsState = EntityStateNotifier<List<Question>>();

  @override
  ListenableState<EntityState<List<Question>>> get questionsState => _questionsState;

  AdminWidgetModel(this._navigator) : super(AdminModel());

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _subscription = model.listenQuestions().listen(_questionsState.content);
  }

  @override
  void dispose() {
    _subscription.cancel();
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
}

abstract class IAdminWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<Question>>> get questionsState;

  void deleteQuestion(Question question);

  void editQuestion(Question question);

  void createNewQuestion();
}
