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
      hint: json['hint'] as String?,
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

  writeNotNull('hint', instance.hint);
  val['type'] = _$QuestionTypeEnumMap[instance.type];
  writeNotNull('questions', instance.answers?.map((e) => e.toJson()).toList());
  val['can_skip'] = instance.canSkip;
  val['hide'] = instance.hide;
  writeNotNull('is_personal', instance.isPersonal);
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
