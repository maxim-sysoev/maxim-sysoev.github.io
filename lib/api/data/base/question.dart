import 'package:quiz/api/data/base/answer.dart';
import 'package:quiz/api/data/base/question_entity.dart';

/// форма вопроса
abstract class Question<Q extends QuestionEntity, A extends Answer> {
  final String text;
  final Q questionEntity;
  A? answer;

  Question(this.text, this.questionEntity, {this.answer});
}
