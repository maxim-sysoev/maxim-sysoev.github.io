import 'package:quiz/api/data/question.dart';

/// вопрос с полем ввода
class InputQuestion extends Question<String> {
  final String hint;
  final bool isPersonalInfo;

  InputQuestion({
    required String text,
    required this.hint,
    required this.isPersonalInfo,
    String? id,
    bool? canSkip,
    bool? hide,
  }) : super(id: id, text: text, canSkip: canSkip, hide: hide);

  @override
  TResult visit<TResult>(IQuestionVisitor<TResult> visitor) => visitor.inputResponse(this);
}
