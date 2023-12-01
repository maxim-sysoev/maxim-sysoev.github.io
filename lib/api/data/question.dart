import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/selection_question.dart';

abstract class Question<T> {
  final String? id;
  final String text;
  final bool canSkip;
  final bool hide;
  T? result;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneOrTelegram;
  String? workOrStudy;

  Question({
    required this.id,
    required this.text,
    this.result,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneOrTelegram,
    this.workOrStudy,
    bool? canSkip,
    bool? hide,
  })  : canSkip = canSkip ?? false,
        hide = hide ?? false;

  TResult visit<TResult>(IQuestionVisitor<TResult> visitor);
}

abstract class IQuestionVisitor<T> {
  T inputResponse(InputQuestion question);

  T selectionResponse(SelectionQuestion question);
}
