import 'package:flutter/material.dart';

import '../../../../model/sheet.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class SheetCard extends StatelessWidget {
  final Sheet sheet;
  final Function(String value) onSelected;

  const SheetCard({super.key, required this.sheet, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
                    value: Text(sheet.type ?? ''),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: onSelected,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.more_vert),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Image.asset(Images.delete, width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Delete Sheet',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Image.asset(Images.edit, width: 20, height: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Edit Sheet',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
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
