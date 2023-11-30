import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

/// Количество вопросов для квиза
const questionsCount = 10;

class HomeModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  Completer<Iterable<Question>>? _completer;

  HomeModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Future<Iterable<Question>> loadQuestions() {
    final completer = _completer;
    if (completer != null) return completer.future;
    _completer = Completer<Iterable<Question>>();
    return _firebaseService.getQuestions().then((value) {
      final visibleQuestions = value.where((element) => !element.hide);
      _completer!.complete(visibleQuestions);
      return visibleQuestions;
    });
  }

  /// Выбирается [questionsCount] вопросов
  ///
  /// Если вопросы ещё не загружены возвращает null
  /// Вопросы со сбором перс данных обязательно включаются в список, остальные выбираются рандомно
  Future<List<Question>?> selectQuestions() async {
    if (!(_completer?.isCompleted ?? false)) return null;
    final questions = await _completer!.future;

    final personalDataQuestions = <Question>[];
    final otherQuestions = <Question>[];
    for (final item in questions) {
      if (item is InputQuestion && item.isPersonalInfo) {
        personalDataQuestions.add(item);
      } else {
        otherQuestions.add(item);
      }
    }

    final randomQuestions = (otherQuestions..shuffle()).take(questionsCount);

    return [...randomQuestions, ...personalDataQuestions];
  }
}
