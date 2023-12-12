import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import 'skeleton.dart';

class Avatar extends StatelessWidget {
  final String? url;
  final String? name;
  final double size;
  final BorderRadius? borderRadius;
  final BoxShape? shape;
  final Color color;
  final double? fontSizes;

  const Avatar({
    Key? key,
    this.url,
    this.name,
    this.size = 40,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.shape,
    this.color = MyColors.primaryColor,
    this.fontSizes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initials = getInitials(name);
    double fontSize = fontSizes ?? size / 2;
    var style = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: fontSize - 6,
          color: Colors.white,
        );
    if (url == null || !url!.contains('http')) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadius,
          color: color,
        ),
        child: Center(child: Text(initials, style: style)),
      );
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url!,
        placeholder: (context, url) {
          return Skeleton(
            height: size,
            width: size,
          );
        },
        imageBuilder: (context, imageProvider) {
          return Image(image: imageProvider, fit: BoxFit.cover);
        },
        errorWidget: (context, url, error) {
          return Center(child: Text(initials, style: style));
        },
      ),
    );
  }

  String getInitials(String? name) {
    if (name?.trim().isEmpty ?? true) return 'PB';
    var list = name!.split('\\s');
    if (list.isEmpty) {
      return 'K';
    } else if (list.length == 1) {
      return list[0][0].toUpperCase();
    } else {
      return '${list[0][0]}${list[1][0]}'.toUpperCase();
    }
  }
}
