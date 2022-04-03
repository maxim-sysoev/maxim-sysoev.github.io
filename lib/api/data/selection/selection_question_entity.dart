import 'package:quiz/api/data/base/question_entity.dart';
import 'package:quiz/api/data/selection/selection_answer.dart';

class SelectionQuestionEntity extends QuestionEntity {
  final List<SelectionAnswer> questions;

  const SelectionQuestionEntity(this.questions);
}
