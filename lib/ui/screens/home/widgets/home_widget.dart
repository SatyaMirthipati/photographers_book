import 'package:flutter/material.dart';

import '../../../widgets/custom_card.dart';

class HomeWidget extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const HomeWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return CustomCard(
      radius: 10,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, width: 40, height: 40),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(title, style: textTheme.titleMedium),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, size: 20)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
