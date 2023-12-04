import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

/// Визитор для создания ответов на вопросы
class QuestionResponseVisitor implements IQuestionVisitor<Response?> {
  @override
  Response? inputResponse(InputQuestion question) {
    final firstName = question.firstName;
    final lastName = question.lastName;
    final email = question.email;
    final phoneOrTelegram = question.phoneOrTelegram;
    final workOrStudy = question.workOrStudy;
    if (firstName == null ||
        firstName.isEmpty ||
        lastName == null ||
        lastName.isEmpty ||
        email == null ||
        email.isEmpty ||
        phoneOrTelegram == null ||
        phoneOrTelegram.isEmpty ||
        workOrStudy == null ||
        workOrStudy.isEmpty) return null;

    return InputResponse(
      question: question.text,
      inputFirstName: firstName,
      inputLastName: lastName,
      inputEmail: email,
      inputPhoneOrTelegram: phoneOrTelegram,
      inputWorkOrStudy: workOrStudy,
    );
  }

  @override
  Response? selectionResponse(SelectionQuestion question) {
    final selectedItems = question.result
        ?.map((e) => SelectedItem(
              response: e.text,
              isCorrect: e.isCorrect,
            ))
        .toList();
    if (selectedItems == null || selectedItems.isEmpty) {
      return null;
    }

    return SelectionResponse(
      question: question.text,
      selectedItems: selectedItems,
    );
  }
}

class QuestionModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  QuestionModel({FirebaseService? firebaseService}) : _firebaseService = firebaseService ?? FirebaseService();

  void saveResult(List<Question> questions) {
    bool isPersonal(Question question) => question is InputQuestion && question.isPersonalInfo;
    final personInfo = questions.firstWhereOrNull(isPersonal);
    final questionVisitor = QuestionResponseVisitor();
    final questionsResult =
        questions.where((e) => !isPersonal(e)).map((e) => e.visit(questionVisitor)).whereType<Response>().toList();

    if (questionsResult.isEmpty) return;

    _firebaseService.saveQuizResult(QuizResult(
      firstName: personInfo?.firstName as String,
      lastName: personInfo?.lastName as String,
      email: personInfo?.email,
      phoneOrTelegram: personInfo?.phoneOrTelegram,
      workOrStudy: personInfo?.workOrStudy,
      responses: questionsResult,
    ));
  }

  /// Считает количество верных ответов
  ///
  /// Если у ответа нет правильного ответа (например, поле ввода), то он считается НЕправильным
  int counterCorrectAnswers(List<Question> questions) {
    final answersCorrectList = questions.where((element) {
      if (element is SelectionQuestion) {
        return element.result?.every((element) => element.isCorrect) ?? false;
      }

      return false;
    });
    return answersCorrectList.length;
  }
}
