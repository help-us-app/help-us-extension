import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/help_us_logo.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          const GradientBackground(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const SafeArea(
              child: Center(
                  child: HelpUsLogo(
                fontSize: 40,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
