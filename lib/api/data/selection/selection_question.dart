import 'package:quiz/api/data/base/question.dart';
import 'package:quiz/api/data/selection/selection_answer.dart';
import 'package:quiz/api/data/selection/selection_question_entity.dart';

/// вопрос с одним правильным ответом
class SelectionQuestion extends Question<SelectionQuestionEntity, SelectionAnswer> {
  SelectionQuestion(
    String text,
    SelectionQuestionEntity answerItem,
  ) : super(text, answerItem);
}
