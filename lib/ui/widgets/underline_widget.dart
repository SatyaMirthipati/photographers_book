import 'package:flutter/material.dart';

import 'bullet_widget.dart';

class UnderlineWidget extends StatelessWidget {
  final String title;

  const UnderlineWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        BulletWidget(),
      ],
    );
  }
}
