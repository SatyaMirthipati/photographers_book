import 'package:flutter/material.dart';

class GridWrap extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int count;

  const GridWrap({
    Key? key,
    this.spacing = 0,
    required this.count,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var itemWidth = (width - (count - 1) * spacing) / count;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var widget in children)
              SizedBox(width: itemWidth, child: widget),
          ],
        );
      },
    );
  }
}
