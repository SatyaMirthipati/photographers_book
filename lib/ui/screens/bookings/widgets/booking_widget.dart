import 'package:flutter/material.dart';

import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';

class BookingWidget extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const BookingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    return CustomCard(
      radius: 10,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              image,
              color: primaryColor,
              width: 40,
              height: 40,
            ),
            title: Text(
              title,
              style: textTheme.titleMedium!.copyWith(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
            trailing: Image.asset(
              Images.left_arrow,
              color: primaryColor,
              width: 15,
              height: 15,
            ),
          ),
        ),
      ),
    );
  }
}
