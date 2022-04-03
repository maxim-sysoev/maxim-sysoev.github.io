import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/base/question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

const _questionsCount = 7;

/// Model of 'HomeScreen'
class HomeModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  HomeModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Future<List<Question>> getQuestions() async {
    final questions = (await _firebaseService.getQuestions()).toList()..shuffle();
    return questions.take(_questionsCount).toList();
  }
}
