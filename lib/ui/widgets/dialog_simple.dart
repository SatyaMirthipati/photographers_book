import 'package:flutter/material.dart';

class SimplestDialog {
  static Future<bool?> show(
    BuildContext context,
    String message, {
    String? title,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
