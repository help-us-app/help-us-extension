import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HelpUsLogo extends StatelessWidget {
  final num fontSize;
  const HelpUsLogo({Key key, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: "help ",
      style: Theme.of(context).textTheme.headline6.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline6.color),
      children: [
        TextSpan(
          text: "us",
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        )
      ],
    ));
  }
}
