// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/response/question_mapper.dart';

const _kQuestions = 'questions';
const _kResults = 'results';

class FirebaseService {
  static final _fireStore = FirebaseFirestore.instance;
  final _questionsCollection = _fireStore.collection(_kQuestions);
  final _resultsCollection = _fireStore.collection(_kResults);

  /// получить список вопросов
  Future<Iterable<Question>> getQuestions() async {
    return _questionsCollection.get().then((value) => value.docs).then(QuestionMapper.transform);
  }
}
