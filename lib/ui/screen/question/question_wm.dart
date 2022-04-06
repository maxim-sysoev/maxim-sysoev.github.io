import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/question/question_model.dart';

QuestionWidgetModel createQuestionWidgetModel(BuildContext context) => QuestionWidgetModel();

class QuestionWidgetModel extends WidgetModel implements IQuestionWidgetModel {
  QuestionWidgetModel() : super(QuestionModel());
}

abstract class IQuestionWidgetModel extends IWidgetModel {}
