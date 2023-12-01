import 'package:flutter/material.dart';

class ImageFromNet extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final String? placeholder;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const ImageFromNet({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.placeholder,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  const ImageFromNet.square({
    Key? key,
    required this.imageUrl,
    required double size,
    this.placeholder,
    this.fit,
    this.borderRadius,
  })  : height = size,
        width = size,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print('imageUrl: ${imageUrl}');
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
      ),
      child: Image.network(
        imageUrl ?? '',
        cacheWidth: width != null ? (width! * devicePixelRatio).round() : null,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            child: child,
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          return Container(
            color: Colors.transparent,
            width: width,
            height: height,
            child: AnimatedOpacity(
              child: child,
              opacity: loadingProgress == null ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            ),
          );
        },
        errorBuilder: (context, obj, s) {
          return Container(
            color: Colors.transparent,
            width: width,
            height: height,
            child: Icon(Icons.broken_image, color: Colors.grey[500], size: 32),
          );
        },
      ),
    );
  }
}
