import 'package:flutter/material.dart';

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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.6),
              ),
            ),
          ),
          TextSpan(
            text: balance.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline2.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size),
          ),
        ],
      ),
    );
  }
}