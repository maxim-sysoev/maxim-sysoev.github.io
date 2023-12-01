import 'package:json_annotation/json_annotation.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';

part 'question_dto.g.dart';

enum QuestionType {
  input,
  single,
  multi,
  unknown,
}

@JsonSerializable()
class QuestionDto {
  final String text;
  final String? email;

  @JsonKey(defaultValue: QuestionType.unknown)
  final QuestionType type;

  @JsonKey(name: 'questions')
  final List<SelectionItemDto>? answers;

  @JsonKey(name: 'can_skip', defaultValue: true)
  final bool canSkip;

  @JsonKey(name: 'hide', defaultValue: false)
  final bool hide;

  @JsonKey(name: 'is_personal')
  final bool? isPersonal;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'phone_or_telegram')
  final String? phoneOrTelegram;

  @JsonKey(name: 'work_or_study')
  final String? workOrStudy;

  const QuestionDto({
    required this.type,
    required this.text,
    required this.canSkip,
    required this.hide,
    this.isPersonal,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneOrTelegram,
    this.workOrStudy,
    this.answers,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) => _$QuestionDtoFromJson(json);

  factory QuestionDto.fromDomain(Question question) {
    if (question is InputQuestion) {
      return QuestionDto(
        type: QuestionType.input,
        text: question.text,
        canSkip: question.canSkip,
        hide: question.hide,
        isPersonal: question.isPersonalInfo,
        firstName: question.firstName,
        lastName: question.lastName,
        email: question.email,
        phoneOrTelegram: question.phoneOrTelegram,
        workOrStudy: question.workOrStudy,
      );
    } else if (question is SelectionQuestion) {
      return QuestionDto(
        type: question.selectionType == SelectionType.multi
            ? QuestionType.multi
            : QuestionType.single,
        text: question.text,
        canSkip: question.canSkip,
        hide: question.hide,
        isPersonal: false,
        answers: question.questions.map(SelectionItemDto.fromDomain).toList(),
      );
    } else {
      throw ArgumentError('Invalid question type of ${question.runtimeType}');
    }
  }

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);

  Question? toDomain(String id) {
    switch (type) {
      case QuestionType.input:
        return InputQuestion(
          id: id,
          firstName: firstName!,
          lastName: lastName!,
          email: email!,
          phoneOrTelegram: phoneOrTelegram!,
          workOrStudy: workOrStudy!,
          isPersonalInfo: isPersonal ?? false,
          text: text,
          hide: hide,
          canSkip: canSkip,
        );

      case QuestionType.single:
      case QuestionType.multi:
        final selectionType =
            type == QuestionType.multi ? SelectionType.multi : SelectionType.single;
        return SelectionQuestion(
          id: id,
          text: text,
          questions: answers!.map((e) => e.toDomain()).toList(),
          selectionType: selectionType,
          canSkip: canSkip,
          hide: hide,
        );

      case QuestionType.unknown:
        return null;
    }
  }
}

@JsonSerializable()
class SelectionItemDto {
  final String text;

  @JsonKey(name: 'is_correct', defaultValue: false)
  final bool isCorrect;

  const SelectionItemDto({
    required this.text,
    required this.isCorrect,
  });

  factory SelectionItemDto.fromJson(Map<String, dynamic> json) => _$SelectionItemDtoFromJson(json);

  factory SelectionItemDto.fromDomain(SelectionItem item) => SelectionItemDto(
        text: item.text,
        isCorrect: item.isCorrect,
      );

  Map<String, dynamic> toJson() => _$SelectionItemDtoToJson(this);

  SelectionItem toDomain() => SelectionItem(
        text,
        isCorrect: isCorrect,
      );
}
