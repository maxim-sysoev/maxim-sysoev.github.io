import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/question/question_model.dart';

QuestionWidgetModel createQuestionWidgetModel({
  required Iterable<Question> questions,
  required BuildContext context,
}) =>
    QuestionWidgetModel();

class QuestionWidgetModel extends WidgetModel implements IQuestionWidgetModel {
  QuestionWidgetModel() : super(QuestionModel());
}

abstract class IQuestionWidgetModel extends IWidgetModel {}
