import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/service/firebase/firebase_service.dart';

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
      _completer!.complete(value);
      return value;
    });
  }
}
