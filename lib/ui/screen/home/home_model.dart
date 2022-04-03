import 'package:elementary/elementary.dart';
import 'package:quiz/api/service/firebase_service.dart';

/// Model of 'HomeScreen'
class HomeModel extends ElementaryModel {
  // ignore: unused_field
  final FirebaseService _firebaseService;

  HomeModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  List<Object?> getQuestions() {
    return <Object?>[];
  }
}
