import 'package:quiz/api/data/base/question.dart';
import 'package:quiz/api/data/input/input_answer.dart';
import 'package:quiz/api/data/input/input_question_entity.dart';

/// вопрос с полем/полями ввода для ответа
///
/// если [InputQuestionEntity.questions] пустое или null - значит одно поле ввода
/// иначе заголовки для каждого поля ввода
class InputQuestion extends Question<InputQuestionEntity, InputAnswer> {
  InputQuestion(
    String text,
    InputQuestionEntity answerItem,
  ) : super(text, answerItem);
}
