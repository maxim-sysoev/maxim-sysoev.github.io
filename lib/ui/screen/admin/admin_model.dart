import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';
import 'package:quiz/api/service/data_export_service/csv_data_export_servise.dart';
import 'package:quiz/api/service/data_export_service/data_export_service.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

class AdminModel extends ElementaryModel {
  final FirebaseService _firebaseService;
  final DataExportService _dataExportService = CsvDataExportService();

  AdminModel({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  Stream<List<Question>> listenQuestions() {
    return _firebaseService.listenQuestions();
  }

  Stream<List<QuizResult>> listenResults() {
    return _firebaseService.listenResults();
  }

  Future<void> deleteQuestion(Question question) async {
    return _firebaseService.deleteQuestion(question);
  }

  void exportFile(List<QuizResult> results, List<Question> questions) {
    if (kIsWeb) {
      _dataExportService.exportResults(results, questions);
    }
  }
}
