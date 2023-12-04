import 'package:quiz/api/data/question.dart';

/// вопрос с полями ввода (сбор контактов)
class InputQuestion extends Question<String> {
  final String inputFirstName;
  final String inputLastName;
  final String inputEmail;
  final String inputPhoneOrTelegram;
  final String inputWorkOrStudy;
  final bool isPersonalInfo;

  InputQuestion({
    required String text,
    required this.inputFirstName,
    required this.inputLastName,
    required this.inputEmail,
    required this.inputPhoneOrTelegram,
    required this.inputWorkOrStudy,
    required this.isPersonalInfo,
    String? id,
    bool? canSkip,
    bool? hide,
  }) : super(id: id, text: text, canSkip: canSkip, hide: hide);

  @override
  TResult visit<TResult>(IQuestionVisitor<TResult> visitor) => visitor.inputResponse(this);
}
