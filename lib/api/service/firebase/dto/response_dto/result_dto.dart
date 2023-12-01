import 'package:json_annotation/json_annotation.dart';
import 'package:quiz/api/data/result/result.dart';

part 'result_dto.g.dart';

@JsonSerializable()
class ResultDto {
  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? email;

  @JsonKey(name: 'phone_or_telegram')
  final String? phoneOrTelegram;

  @JsonKey(name: 'work_or_study')
  final String? workOrStudy;

  @JsonKey(name: 'questions')
  final List<ResponseDto> questionResponses;

  const ResultDto({
    required this.questionResponses,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneOrTelegram,
    this.workOrStudy,
  });

  factory ResultDto.fromJson(Map<String, dynamic> json) => _$ResultDtoFromJson(json);

  factory ResultDto.fromDomain(QuizResult result) {
    return ResultDto(
      firstName: result.firstName,
      lastName: result.lastName,
      email: result.email,
      phoneOrTelegram: result.phoneOrTelegram,
      workOrStudy: result.workOrStudy,
      questionResponses: result.responses.map(ResponseDto.fromDomain).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$ResultDtoToJson(this);

  QuizResult toDomain() => QuizResult(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneOrTelegram: phoneOrTelegram,
        workOrStudy: workOrStudy,
        responses: questionResponses.map((e) => e.toDomain()).whereType<Response>().toList(),
      );
}

@JsonSerializable()
class ResponseDto {
  final String question;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? email;

  @JsonKey(name: 'phone_or_telegram')
  final String? phoneOrTelegram;

  @JsonKey(name: 'work_or_study')
  final String? workOrStudy;

  @JsonKey(name: 'result')
  final List<SelectedResponseDto>? response;

  const ResponseDto({
    required this.question,
    this.response,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneOrTelegram,
    this.workOrStudy,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) => _$ResponseDtoFromJson(json);

  factory ResponseDto.fromDomain(Response response) {
    return ResponseDto(
      question: response.question,
      firstName: (response is InputResponse) ? response.inputFirstName : null,
      lastName: (response is InputResponse) ? response.inputLastName : null,
      email: (response is InputResponse) ? response.inputEmail : null,
      phoneOrTelegram: (response is InputResponse) ? response.inputPhoneOrTelegram : null,
      workOrStudy: (response is InputResponse) ? response.inputWorkOrStudy : null,
      response: (response is SelectionResponse)
          ? response.selectedItems.map(SelectedResponseDto.fromDomain).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);

  Response? toDomain() {
    final list = response;
    final firstName = this.firstName;
    final lastName = this.lastName;
    final email = this.email;
    final phoneOrTelegram = this.phoneOrTelegram;
    final workOrStudy = this.workOrStudy;
    if (list != null && list.isNotEmpty) {
      return SelectionResponse(
        question: question,
        selectedItems: list.map((e) => e.toDomain()).toList(),
      );
    } else if (firstName != null &&
        firstName.isNotEmpty &&
        lastName != null &&
        lastName.isNotEmpty &&
        email != null &&
        email.isNotEmpty &&
        phoneOrTelegram != null &&
        phoneOrTelegram.isNotEmpty &&
        workOrStudy != null &&
        workOrStudy.isNotEmpty) {
      return InputResponse(
        question: question,
        inputFirstName: firstName,
        inputLastName: lastName,
        inputEmail: email,
        inputPhoneOrTelegram: phoneOrTelegram,
        inputWorkOrStudy: workOrStudy,
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
