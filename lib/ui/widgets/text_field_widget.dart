import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? filled;
  final bool? autofocus;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final ValueChanged? onChanged;
  final TextStyle? style;

  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.hintText,
    this.maxLines,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.filled,
    this.autofocus,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.titleSmall),
            const SizedBox(height: 6),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              autofocus: autofocus ?? false,
              focusNode: focusNode,
              maxLines: maxLines,
              controller: controller,
              style: style ?? textTheme.titleMedium,
              cursorHeight: 22,
              cursorWidth: 1,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onChanged: onChanged,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                filled: filled,
                hintText: hintText,
                hintStyle: textTheme.titleMedium!.copyWith(
                  color: Colors.black.withOpacity(0.5),
                ),
                suffixIcon: const SizedBox(width: 1),
              ),
            )
          ],
        ),
        Positioned(
          right: 15,
          top: 40,
          child: suffixIcon ?? Container(),
        )
      ],
    );
  }
}
