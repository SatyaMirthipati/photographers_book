import 'package:flutter/material.dart';

import '../../../../resources/colors.dart';

class ProfileWidget extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const ProfileWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(image, width: 35, height: 35),
          title: Text(title, style: textTheme.bodyMedium),
          trailing: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: MyColors.accentColor2.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4)),
            child: const Center(
              child: Icon(Icons.chevron_right, color: Colors.black, size: 20),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Divider(color: MyColors.border.withOpacity(0.25)),
      ],
    );
  }
}
