import 'package:quiz/api/data/base/answer.dart';

/// ответ на вопрос (верный или нет)
class SelectionAnswer extends Answer {
  final String text;
  final bool isCorrect;

  const SelectionAnswer(this.text, {this.isCorrect = false});
}
