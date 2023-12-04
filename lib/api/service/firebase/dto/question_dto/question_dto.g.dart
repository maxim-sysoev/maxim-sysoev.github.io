// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']) ??
          QuestionType.unknown,
      text: json['text'] as String,
      canSkip: json['can_skip'] as bool? ?? true,
      hide: json['hide'] as bool? ?? false,
      isPersonal: json['is_personal'] as bool?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneOrTelegram: json['phone_or_telegram'] as String?,
      workOrStudy: json['work_or_study'] as String?,
      answers: (json['questions'] as List<dynamic>?)
          ?.map((e) => SelectionItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) {
  final val = <String, dynamic>{
    'text': instance.text,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  val['type'] = _$QuestionTypeEnumMap[instance.type];
  writeNotNull('questions', instance.answers?.map((e) => e.toJson()).toList());
  val['can_skip'] = instance.canSkip;
  val['hide'] = instance.hide;
  writeNotNull('is_personal', instance.isPersonal);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('phone_or_telegram', instance.phoneOrTelegram);
  writeNotNull('work_or_study', instance.workOrStudy);
  return val;
}

const _$QuestionTypeEnumMap = {
  QuestionType.input: 'input',
  QuestionType.single: 'single',
  QuestionType.multi: 'multi',
  QuestionType.unknown: 'unknown',
};

SelectionItemDto _$SelectionItemDtoFromJson(Map<String, dynamic> json) =>
    SelectionItemDto(
      text: json['text'] as String,
      isCorrect: json['is_correct'] as bool? ?? false,
    );

Map<String, dynamic> _$SelectionItemDtoToJson(SelectionItemDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'is_correct': instance.isCorrect,
    };
