import 'package:flutter/material.dart';

class ReverseDetailsTile extends StatelessWidget {
  final Widget title;
  final Widget value;
  final double? gap;

  const ReverseDetailsTile({
    Key? key,
    required this.title,
    required this.value,
    this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: textTheme.titleMedium!.copyWith(fontSize: 16, height: 26 / 18),
          child: title,
        ),
        SizedBox(height: gap ?? 4),
        DefaultTextStyle(
          style: textTheme.titleMedium!.copyWith(
            color: Colors.black.withOpacity(0.5),
            height: 26 / 14,
            fontSize: 14,
          ),
          child: value,
        ),
      ],
    );
  }
}
