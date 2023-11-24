// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultDto _$ResultDtoFromJson(Map<String, dynamic> json) => ResultDto(
      questionResponses: (json['questions'] as List<dynamic>)
          .map((e) => ResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      person: json['person'] as String?,
    );

Map<String, dynamic> _$ResultDtoToJson(ResultDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('person', instance.person);
  val['questions'] = instance.questionResponses.map((e) => e.toJson()).toList();
  return val;
}

ResponseDto _$ResponseDtoFromJson(Map<String, dynamic> json) => ResponseDto(
      question: json['question'] as String,
      response: (json['result'] as List<dynamic>?)
          ?.map((e) => SelectedResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      inputResponse: json['inputResult'] as String?,
    );

Map<String, dynamic> _$ResponseDtoToJson(ResponseDto instance) {
  final val = <String, dynamic>{
    'question': instance.question,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inputResult', instance.inputResponse);
  writeNotNull('result', instance.response?.map((e) => e.toJson()).toList());
  return val;
}

SelectedResponseDto _$SelectedResponseDtoFromJson(Map<String, dynamic> json) =>
    SelectedResponseDto(
      text: json['question'] as String,
      isCorrect: json['result'] as bool,
    );

Map<String, dynamic> _$SelectedResponseDtoToJson(
        SelectedResponseDto instance) =>
    <String, dynamic>{
      'question': instance.text,
      'result': instance.isCorrect,
    };
