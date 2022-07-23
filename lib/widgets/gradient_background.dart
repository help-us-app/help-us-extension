import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.9, 2),
          tileMode: TileMode.decal,
          colors: [
            Colors.black,
            Colors.grey[900].withOpacity(0.5),
          ],
        ),
      ),
    );
  }
}
