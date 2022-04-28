import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:quiz/config/firebase_config.dart';
import 'package:quiz/ui/app/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = const Locale('ru', 'RU').toLanguageTag();
  await Firebase.initializeApp(options: FirebaseConfig.config);
  runApp(const App());
}
