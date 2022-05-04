import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

class AdminModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  AdminModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Stream<List<Question>> listenQuestions() {
    return _firebaseService.listenQuestions();
  }

  Future<void> deleteQuestion(Question question) async {
    return _firebaseService.deleteQuestion(question);
  }
}
