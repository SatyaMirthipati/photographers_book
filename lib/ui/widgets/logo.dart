import 'package:flutter/material.dart';

import '../../resources/images.dart';

class Logo extends StatelessWidget {
  final double size;
  final bool color;

  const Logo({Key? key, this.size = 150, this.color = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Image.asset(Images.logo, height: size, width: size),
    );
  }
}
