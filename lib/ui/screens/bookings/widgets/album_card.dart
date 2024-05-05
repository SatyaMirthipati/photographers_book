import 'package:flutter/material.dart';

import '../../../../model/booking_sheet.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class AlbumCard extends StatelessWidget {
  final BookingSheet bookingSheet;

  const AlbumCard({super.key, required this.bookingSheet});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: 5,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: DetailsTile(
                title: const Text('Sheet Type'),
                value: Text(bookingSheet.sheet ?? ''),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DetailsTile(
                title: const Text('Quantity'),
                value: Text(bookingSheet.quantity ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
