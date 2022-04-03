import 'package:quiz/api/data/base/question_entity.dart';

/// пункт(ы) вопроса для поля(ей) ввода
class InputQuestionEntity extends QuestionEntity {
  final List<String>? questions;

  const InputQuestionEntity(this.questions);
}
