import 'package:flutter/material.dart';

import 'image_from_net.dart';

class ImageBorder extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ImageBorder({
    Key? key,
    this.imageUrl,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: ImageFromNet(
        height: height,
        width: width,
        imageUrl: imageUrl,
        fit: fit,
      ),
    );
  }
}
