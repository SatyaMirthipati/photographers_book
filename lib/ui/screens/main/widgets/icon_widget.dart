import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';

class IconWidget extends StatelessWidget {
  final String image;
  final bool selected;
  final VoidCallback onTap;
  final String text;

  const IconWidget({
    Key? key,
    required this.image,
    required this.selected,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              image,
              height: 22,
              width: 25,
            ),
          ),
          Text(
            text,
            style: textTheme.titleSmall!.copyWith(
              color: MyColors.accentColor,
              fontSize: 11,
              height: 12 / 11,
            ),
          )
        ],
      ),
    );
  }
}
