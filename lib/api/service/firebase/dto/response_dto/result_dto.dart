import 'package:json_annotation/json_annotation.dart';
import 'package:quiz/api/data/result/result.dart';

part 'result_dto.g.dart';

@JsonSerializable()
class ResultDto {
  final String? person;

  @JsonKey(name: 'questions')
  final List<ResponseDto> questionResponses;

  const ResultDto({
    required this.questionResponses,
    this.person,
  });

  factory ResultDto.fromJson(Map<String, dynamic> json) => _$ResultDtoFromJson(json);

  factory ResultDto.fromDomain(QuizResult result) {
    return ResultDto(
      person: result.person,
      questionResponses: result.responses.map(ResponseDto.fromDomain).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$ResultDtoToJson(this);

  QuizResult toDomain() => QuizResult(
        person: person,
        responses: questionResponses.map((e) => e.toDomain()).whereType<Response>().toList(),
      );
}

@JsonSerializable()
class ResponseDto {
  final String question;

  @JsonKey(name: 'inputResult')
  final String? inputResponse;

  @JsonKey(name: 'result')
  final List<SelectedResponseDto>? response;

  const ResponseDto({
    required this.question,
    this.response,
    this.inputResponse,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) => _$ResponseDtoFromJson(json);

  factory ResponseDto.fromDomain(Response response) {
    return ResponseDto(
      question: response.question,
      inputResponse: (response is InputResponse) ? response.inputResult : null,
      response: (response is SelectionResponse)
          ? response.selectedItems.map(SelectedResponseDto.fromDomain).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);

  Response? toDomain() {
    final list = response;
    final input = inputResponse;
    if (list != null && list.isNotEmpty) {
      return SelectionResponse(
        question: question,
        selectedItems: list.map((e) => e.toDomain()).toList(),
      );
    } else if (input != null && input.isNotEmpty) {
      return InputResponse(
        question: question,
        inputResult: input,
      );
    } else {
      return null;
    }
  }
}

@JsonSerializable()
class SelectedResponseDto {
  @JsonKey(name: 'question')
  final String text;

  @JsonKey(name: 'result')
  final bool isCorrect;

  const SelectedResponseDto({
    required this.text,
    required this.isCorrect,
  });

  factory SelectedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SelectedResponseDtoFromJson(json);

  factory SelectedResponseDto.fromDomain(SelectedItem item) => SelectedResponseDto(
        text: item.response,
        isCorrect: item.isCorrect,
      );

  Map<String, dynamic> toJson() => _$SelectedResponseDtoToJson(this);

  SelectedItem toDomain() => SelectedItem(response: text, isCorrect: isCorrect);
}
