import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';

/// App root entry
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.white,
      home: HomeScreen(),
    );
  }
}
