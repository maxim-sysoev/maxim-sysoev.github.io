import 'package:cloud_firestore/cloud_firestore.dart';

const _kQuestions = 'questions';
const _kResults = 'results';

class FirebaseService {
  static final _fireStore = FirebaseFirestore.instance;
  final _questionsCollection = _fireStore.collection(_kQuestions);
  final _resultsCollection = _fireStore.collection(_kResults);
}
