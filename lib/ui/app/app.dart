import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/home_screen.dart';
import 'package:quiz/ui/util/screen_size_holder.dart';
import 'package:quiz/ui/widgets/background_painter.dart';

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
    return WidgetsApp(
      color: Colors.transparent,
      builder: (_, widget) => Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: Colors.white)),
          Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),
          const MaterialApp(
            color: Colors.transparent,
            home: HomeScreen(),
          ),
        ],
      ),
    );
  }
}
