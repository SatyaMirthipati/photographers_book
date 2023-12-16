import 'package:flutter/material.dart';

import '../../../../model/sheet.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class SheetCard extends StatelessWidget {
  final Sheet sheet;

  const SheetCard({super.key, required this.sheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CustomCard(
        radius: 5,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DetailsTile(
                    title: const Text('Sheet Type'),
                    value: Text(sheet.sheetType ?? ''),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 15),
              DetailsTile(
                title: const Text('Price'),
                value: Text('${sheet.price ?? ''}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
