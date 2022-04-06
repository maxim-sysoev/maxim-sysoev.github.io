import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';

const _type = 'type';
const _text = 'text';
const _hint = 'hint';
const _input = 'input';
const _single = 'single';
const _multi = 'multi';
const _questions = 'questions';
const _isCorrect = 'is_correct';
const _canSkip = 'can_skip';
const _isPersonal = 'is_personal';

class QuestionMapper {
  static Iterable<Question> transform(List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    return data.map((doc) {
      final id = doc.id;
      final docData = doc.data();
      final questionType = docData[_type] as String;
      final text = docData[_text] as String;
      final canSkip = docData[_canSkip] as bool? ?? true;
      switch (questionType) {
        case _single:
        case _multi:
          final selectionType = questionType == _multi ? SelectionType.multi : SelectionType.single;
          final questions = (docData[_questions] as List<dynamic>)
              .cast<Map<String, Object?>>()
              .map<SelectionItem>(
                (e) => SelectionItem(
                  e[_text] as String,
                  isCorrect: e[_isCorrect] as bool?,
                ),
              );
          return SelectionQuestion(
            id: id,
            text: text,
            questions: questions,
            selectionType: selectionType,
            canSkip: canSkip,
          );
        case _input:
          return InputQuestion(
            id: id,
            text: text,
            hint: docData[_hint] as String? ?? '',
            canSkip: canSkip,
            isPersonalInfo: docData[_isPersonal] as bool? ?? false,
          );
        default:
          return null;
      }
    }).whereType<Question>();
  }
}
