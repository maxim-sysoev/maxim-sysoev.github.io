import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

const _person = 'person';
const _question = 'question';
const _result = 'result';
const _questions = 'questions';

class QuestionModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  QuestionModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  void saveResult(List<Question> questions) {
    final result = <String, Object?>{};
    bool isPersonal(Question question) => question is InputQuestion && question.isPersonalInfo;
    final personInfo = questions.firstWhereOrNull(isPersonal);
    if (personInfo != null) result[_person] = personInfo.result;
    final questionsResult = questions
        .where((e) => !isPersonal(e))
        .map(
          (e) {
            Object? result;
            if (e is SelectionQuestion) {
              result = e.result
                  ?.map((e) => <String, Object>{_question: e.text, _result: e.isCorrect})
                  .toList();
            } else {
              result = e.result;
            }
            if (result == null) return null;
            return <String, Object?>{
              _question: e.text,
              _result: result,
            };
          },
        )
        .whereType<Object>()
        .toList();
    if (questionsResult.isEmpty) return;
    result[_questions] = questionsResult;
    _firebaseService.saveQuizResult(result);
  }
}
