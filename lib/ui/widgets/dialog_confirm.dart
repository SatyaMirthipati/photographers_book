import 'package:flutter/material.dart';

import '../../../resources/colors.dart';


class ConfirmDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String message,
    String? title,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var textTheme = Theme.of(context).textTheme;
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: textTheme.titleLarge!.copyWith(
                    color: MyColors.primaryColor,
                  ),
                )
              : null,
          content: Text(
            message,
            style: textTheme.bodyLarge!.copyWith(color: MyColors.primaryColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: MyColors.background,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'NO',
                style: textTheme.headlineSmall!.copyWith(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'YES',
                style: textTheme.headlineSmall!.copyWith(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
