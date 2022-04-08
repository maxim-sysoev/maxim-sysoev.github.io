import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';
import 'package:quiz/ui/util/screen_size_holder.dart';

/// App root entry
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    ScreenSizeHolder.init();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        ScreenSizeHolder.update();
        return const MaterialApp(
          color: Colors.white,
          home: HomeScreen(),
        );
      },
    );
  }
}
