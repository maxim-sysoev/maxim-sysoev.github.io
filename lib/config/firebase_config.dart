import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBlS8uwBCPQkJkpenmGYNER9P_OHKEhNvI',
    authDomain: 'surf-quiz-7f420.firebaseapp.com',
    projectId: 'surf-quiz-7f420',
    storageBucket: 'surf-quiz-7f420.appspot.com',
    messagingSenderId: '130648126568',
    appId: '1:130648126568:web:352bfa3f508db0118cb7dd',
    measurementId: 'G-RKZ1V6113G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwUOB9R8A89p2gAnpVBuW2kHoq9rq1SC0',
    authDomain: 'surf-quiz-7f420.firebaseapp.com',
    projectId: 'surf-quiz-7f420',
    storageBucket: 'surf-quiz-7f420.appspot.com',
    messagingSenderId: '130648126568',
    appId: '1:130648126568:android:92a32ad59224b3df8cb7dd',
    measurementId: 'G-RKZ1V6113G',
  );

  static FirebaseOptions get config {
    if (kIsWeb) return web;
    if (Platform.isAndroid) return android;
    if (Platform.isIOS) return android; // TODO(arefimenko): impl macos project
    throw UnimplementedError();
  }
}
