import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/dto/question_dto/question_dto.dart';

const _kQuestions = 'questions';
const _kResults = 'results';

class FirebaseService {
  static final _fireStore = FirebaseFirestore.instance;
  final _questionsCollection = _fireStore.collection(_kQuestions);
  final _resultsCollection = _fireStore.collection(_kResults);

  /// получить список вопросов
  Future<Iterable<Question>> getQuestions() async {
    return _questionsCollection.get().then(_mapQuestionsList);
  }

  /// Подписка на список вопросов
  Stream<List<Question>> listenQuestions() {
    return _questionsCollection.snapshots().map(_mapQuestionsList);
  }

  /// Создать новый вопрос
  Future<void> createQuestion(Question question) async {
    await _questionsCollection.add(QuestionDto.fromDomain(question).toJson());
  }

  /// Удаление вопроса из списка
  Future<void> deleteQuestion(Question question) {
    return _questionsCollection.doc(question.id).delete();
  }

  /// Обновить вопрос
  Future<void> updateQuestion(Question question) async {
    await _questionsCollection.doc(question.id).update(QuestionDto.fromDomain(question).toJson());
  }

  /// сохранить результат квиза
  Future<void> saveQuizResult(Map<String, Object?> data) => _resultsCollection.add(data);

  List<Question> _mapQuestionsList(QuerySnapshot<Map<String, dynamic>> value) {
    return value.docs
        .map((e) => QuestionDto.fromJson(e.data()).toDomain(e.id))
        .whereType<Question>()
        .toList();
  }
}
