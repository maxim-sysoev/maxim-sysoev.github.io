import 'package:quiz/api/data/input/input_question.dart';
import 'package:quiz/api/data/selection/multi/multi_question.dart';
import 'package:quiz/api/data/selection/selection_question.dart';

/// тип вопроса
enum QuestionType {
  /// выбор одного ответа [SelectionQuestion]
  selection,

  /// множественный выбор ответов [MultiQuestion]
  multi,

  /// вопрос с полем(ями) ввода для ответа(ов) [InputQuestion]
  input,

  /// вопрос не определён
  none,
}
