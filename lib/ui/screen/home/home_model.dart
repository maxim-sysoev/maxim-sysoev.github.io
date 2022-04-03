import 'package:elementary/elementary.dart';
import 'package:quiz/service/firebase_service.dart';

/// Model of 'HomeScreen'
class HomeModel extends ElementaryModel {
  final FirebaseService _firebaseService;

  HomeModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  List<Object?> getQuestions() {
    return <Object?>[];
  }
}
