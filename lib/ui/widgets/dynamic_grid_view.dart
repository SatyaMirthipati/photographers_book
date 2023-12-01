import 'package:flutter/material.dart';

class DynamicGridView extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int count;

  const DynamicGridView({
    Key? key,
    required this.spacing,
    required this.children,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = ((constraints.maxWidth - (count - 1) * spacing) ~/ count)
            .toDouble();
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}
