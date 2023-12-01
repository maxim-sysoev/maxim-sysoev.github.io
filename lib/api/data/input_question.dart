import 'package:quiz/api/data/question.dart';

/// вопрос с полями ввода (сбор контактов)
class InputQuestion extends Question<String> {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneOrTelegram;
  final String workOrStudy;
  final bool isPersonalInfo;

  InputQuestion({
    required String text,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneOrTelegram,
    required this.workOrStudy,
    required this.isPersonalInfo,
    String? id,
    bool? canSkip,
    bool? hide,
  }) : super(id: id, text: text, canSkip: canSkip, hide: hide);

  @override
  TResult visit<TResult>(IQuestionVisitor<TResult> visitor) => visitor.inputResponse(this);
}
