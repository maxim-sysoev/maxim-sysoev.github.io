import 'package:quiz/api/data/base/question.dart';
import 'package:quiz/api/data/selection/multi/multi_answer.dart';
import 'package:quiz/api/data/selection/selection_question_entity.dart';

/// вопрос с множественным кол-вом ответов
class MultiQuestion extends Question<SelectionQuestionEntity, MultiSelectionAnswer> {
  MultiQuestion(
    String text,
    SelectionQuestionEntity questionEntity,
  ) : super(text, questionEntity);
}
