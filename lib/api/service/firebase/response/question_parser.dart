import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/api/data/base/question.dart';
import 'package:quiz/api/data/input/input_question.dart';
import 'package:quiz/api/data/input/input_question_entity.dart';
import 'package:quiz/api/data/selection/multi/multi_question.dart';
import 'package:quiz/api/data/selection/selection_answer.dart';
import 'package:quiz/api/data/selection/selection_question.dart';
import 'package:quiz/api/data/selection/selection_question_entity.dart';

const _type = 'type';
const _selection = 'selection';
const _multi = 'multi';
const _input = 'input';
const _questionEntities = 'question_entities';
const _text = 'text';
const _isCorrect = 'is_correct';

/// парсер вопросов
class QuestionsParser {
  static Iterable<Question> parseQuestions(
    List<QueryDocumentSnapshot<Map<String, Object?>>> snapshots,
  ) {
    return snapshots.map((e) {
      if (!e.exists) return null;
      final data = e.data();
      final questionType = data[_type] as String;
      switch (questionType) {
        case _selection:
          return _SelectionQuestionMapper(data).parseQuestion();
        case _multi:
          return _MultiQuestionMapper(data).parseQuestion();
        case _input:
          return _InputQuestionMapper(data).parseQuestion();
        default:
          return null;
      }
    }).whereType<Question>();
  }
}

// ignore: one_member_abstracts
abstract class _QuestionMapper<T extends Question> {
  final Map<String, Object?> _data;

  _QuestionMapper(this._data);

  T parseQuestion();
}

class _SelectionQuestionMapper extends _QuestionMapper<SelectionQuestion> {
  _SelectionQuestionMapper(Map<String, Object?> data) : super(data);

  @override
  SelectionQuestion parseQuestion() {
    final text = _data[_text] as String;
    final questionItems = _data[_questionEntities] as List<dynamic>;
    return SelectionQuestion(text, _SelectionEntitiesParser(questionItems).getItems());
  }
}

class _MultiQuestionMapper extends _QuestionMapper<MultiQuestion> {
  _MultiQuestionMapper(Map<String, Object?> data) : super(data);

  @override
  MultiQuestion parseQuestion() {
    final text = _data[_text] as String;
    final questionItems = _data[_questionEntities] as List<dynamic>;
    return MultiQuestion(text, _SelectionEntitiesParser(questionItems).getItems());
  }
}

class _InputQuestionMapper extends _QuestionMapper<InputQuestion> {
  _InputQuestionMapper(Map<String, Object?> data) : super(data);

  @override
  InputQuestion parseQuestion() {
    final text = _data[_text] as String;
    final questionItems = _data[_questionEntities] as List<dynamic>?;
    return InputQuestion(text, InputQuestionEntity(questionItems?.cast<String>()));
  }
}

class _SelectionEntitiesParser {
  final List<dynamic> _list;

  _SelectionEntitiesParser(this._list);

  SelectionQuestionEntity getItems() {
    return SelectionQuestionEntity(
      _list.cast<Map<String, Object?>>().map(
            (e) => SelectionAnswer(
              e[_text] as String,
              isCorrect: e[_isCorrect] as bool,
            ),
          ),
    );
  }
}
