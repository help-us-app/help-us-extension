import 'package:flutter/material.dart';
import 'package:help_us_extension/utils/app_colors.dart';

class PriceFormatter {
  static Widget numberString(num balance, BuildContext context, num size) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -7.0),
              child: Text(
                '\$',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.6),
              ),
            ),
          ),
          TextSpan(
            text: balance.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: size),
          ),
        ],
      ),
    );
  }
}
