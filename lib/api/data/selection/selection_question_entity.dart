import 'package:quiz/api/data/base/question_entity.dart';
import 'package:quiz/api/data/selection/selection_answer.dart';

class SelectionQuestionEntity extends QuestionEntity {
  final Iterable<SelectionAnswer> questions;

  const SelectionQuestionEntity(this.questions);
}
