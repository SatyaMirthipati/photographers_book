import 'package:flutter/material.dart';

import '../../../resources/images.dart';

class EmptyWidget extends StatelessWidget {
  final String? image;
  final String message;
  final String? subtitle;
  final double size;
  final Color? fontColor;

  const EmptyWidget({
    Key? key,
    this.image,
    this.message = 'No Data Found',
    this.size = 60,
    this.subtitle,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image ?? Images.logo,
              height: size,
              width: size,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: textTheme.titleSmall?.copyWith(
                color: fontColor,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (subtitle != null)
              Text(
                '$subtitle',
                style: textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
          ],
        ),
      ),
    );
  }
}
