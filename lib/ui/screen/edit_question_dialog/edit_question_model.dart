import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_wm.dart';

class QuestionInfo {
  final String question;
  final String hint;
  final QuestionType questionType;
  final bool canSkip;
  final bool isHidden;
  final bool isPersonalData;
  final List<AnswerInfo> answersList;

  const QuestionInfo({
    required this.question,
    required this.hint,
    required this.questionType,
    required this.canSkip,
    required this.isHidden,
    required this.isPersonalData,
    required this.answersList,
  });
}

class AnswerInfo {
  final String answer;
  final bool isCorrect;

  const AnswerInfo({
    required this.answer,
    required this.isCorrect,
  });
}

class EditQuestionModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  EditQuestionModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Future<bool> createQuestion(QuestionInfo info) async {
    if (!_validateQuestionInfo(info)) return false;
    final question = _createQuestionObject(info);
    return _firebaseService.createQuestion(question).then((value) => true);
  }

  Future<bool> updateQuestion(String id, QuestionInfo info) async {
    if (!_validateQuestionInfo(info)) return false;
    final question = _createQuestionObject(info, id);
    return _firebaseService.updateQuestion(question).then((value) => true);
  }

  bool _validateQuestionInfo(QuestionInfo info) {
    if (info.question.isEmpty) return false;

    switch (info.questionType) {
      case QuestionType.input:
        if (info.hint.isEmpty) return false;
        return true;

      case QuestionType.selection:
        if (info.answersList.isEmpty) return false;
        if (info.answersList.any((e) => e.answer.isEmpty)) return false;
        if (info.answersList.every((e) => e.isCorrect)) return false;
        return true;
    }
  }

  Question _createQuestionObject(QuestionInfo info, [String? id]) {
    switch (info.questionType) {
      case QuestionType.input:
        return InputQuestion(
          id: id,
          text: info.question,
          hint: info.hint,
          isPersonalInfo: info.isPersonalData,
          canSkip: info.canSkip,
          hide: info.isHidden,
        );

      case QuestionType.selection:
        final answers = info.answersList
            .map((e) => SelectionItem(
                  e.answer,
                  isCorrect: e.isCorrect,
                ))
            .toList();
        final correctCount = answers.where((element) => element.isCorrect).length;

        return SelectionQuestion(
          id: id,
          text: info.question,
          questions: answers,
          selectionType: correctCount > 1 ? SelectionType.multi : SelectionType.single,
          hide: info.isHidden,
          canSkip: info.canSkip,
        );
    }
  }
}
