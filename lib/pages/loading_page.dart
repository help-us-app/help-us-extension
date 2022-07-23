import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/gradient_background.dart';

class LoadingPage extends StatelessWidget {
  final String text;

  const LoadingPage({
    Key key,
    this.text,
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[800]
                          : Colors.white,
                    )),
                  ),
                  if (text != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.secondary
                                : AppColors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
