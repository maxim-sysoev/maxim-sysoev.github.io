import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

class HomeModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  HomeModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Future<Iterable<Question>> loadQuestions() {
    return _firebaseService.getQuestions();
  }
}
