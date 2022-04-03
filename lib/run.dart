import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/config/firebase_config.dart';
import 'package:quiz/ui/app/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseConfig.config);
  runApp(const App());
}
