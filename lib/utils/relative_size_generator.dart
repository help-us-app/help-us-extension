import 'package:flutter/material.dart';
import 'package:help_us_extension/utils/strings.dart';

class RelativeSizeGenerator {
  static generate(BuildContext context, num size, String type) {
    if (type == Strings.width) {
      return MediaQuery.of(context).size.width * size;
    }
    return MediaQuery.of(context).size.height * size;
  }

  static Widget generateWidget(BuildContext context, num size, String type) {
    if (type == Strings.width) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * size,
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * size,
    );
  }
}
