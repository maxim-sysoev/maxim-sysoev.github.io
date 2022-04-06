import 'package:quiz/api/data/question.dart';

/// вопрос с полем ввода
class InputQuestion extends Question<String> {
  final String hint;
  final bool isPersonalInfo;

  InputQuestion({
    required String id,
    required String text,
    required this.hint,
    required this.isPersonalInfo,
    bool? canSkip,
  }) : super(id: id, text: text, canSkip: canSkip);
}
