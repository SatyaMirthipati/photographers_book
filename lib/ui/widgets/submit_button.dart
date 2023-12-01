import 'package:flutter/material.dart';

class SubmitlabelLarge extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? widthFactor;
  final double? fontSize;

  const SubmitlabelLarge({
    Key? key,
    required this.onPressed,
    required this.text,
    this.widthFactor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textTheme.labelLarge?.copyWith(
            fontSize: fontSize ?? 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
