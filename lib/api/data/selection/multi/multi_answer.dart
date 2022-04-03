import 'package:quiz/api/data/base/answer.dart';
import 'package:quiz/api/data/selection/selection_answer.dart';

/// множественно верные ответы
class MultiSelectionAnswer<T extends SelectionAnswer> extends Answer {
  final Iterable<T> answers;

  const MultiSelectionAnswer(this.answers);
}
