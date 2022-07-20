import 'package:flutter/material.dart';

class Messenger {
  static sendSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        )));
  }
}