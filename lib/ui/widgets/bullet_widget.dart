import 'package:flutter/material.dart';

class BulletWidget extends StatelessWidget {
  const BulletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).colorScheme.secondary;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 4,
        width: 30,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
