import 'package:quiz/api/data/question.dart';

/// вопрос с полем ввода
class InputQuestion extends Question<String> {
  final String? hint;

  InputQuestion({
    required String id,
    required String text,
    this.hint,
  }) : super(id: id, text: text);
}
