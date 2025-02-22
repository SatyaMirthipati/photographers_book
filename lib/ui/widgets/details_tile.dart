import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  final Widget? title;
  final Widget? value;
  final EdgeInsets padding;
  final double? gap;

  const DetailsTile({
    Key? key,
    this.title,
    this.value,
    this.padding = const EdgeInsets.all(0),
    this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: textTheme.titleSmall!.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
            ),
            child: title!,
          ),
          SizedBox(height: gap ?? 5),
          DefaultTextStyle(
            style: textTheme.titleSmall!.copyWith(fontSize: 14),
            child: value!,
          ),
        ],
      ),
    );
  }
}
