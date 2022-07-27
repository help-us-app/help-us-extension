import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HelpUsLogo extends StatelessWidget {
  final num fontSize;
  final bool hasForChrome;
  const HelpUsLogo({Key key, this.fontSize, this.hasForChrome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: "help ",
      style: Theme.of(context).textTheme.headline6.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline6.color,
          fontFamily: "Mont"),
      children: [
        TextSpan(
          text: "us",
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              fontFamily: "Mont",
              color: AppColors.primary),
        ),
        if (hasForChrome != null)
          TextSpan(
            text: ' for ',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 20,
                ),
          ),
        if (hasForChrome != null)
          TextSpan(
            text: 'Chrome',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          )
      ],
    ));
  }
}
