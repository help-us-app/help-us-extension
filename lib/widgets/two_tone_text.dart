import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TwoToneText extends StatelessWidget {
  final String firstText, secondText, tag;
  const TwoToneText({Key key, this.firstText, this.secondText, this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 20, color: Theme.of(context).textTheme.headline6.color),
          children: [
            TextSpan(
              text: secondText,
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: AppColors.primary,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
