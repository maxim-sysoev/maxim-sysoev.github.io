import 'package:flutter/material.dart';
import 'package:quiz/ui/screen/home/widgets/surf_logo.dart';

/// HomeScreen medium layout UI
class HomeMediumLayout extends StatelessWidget {
  const HomeMediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: SurfLogo(height: 250),
            ),
          ),
          Expanded(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
