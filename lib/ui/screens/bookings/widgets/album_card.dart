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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsTile(
              title: const Text('Sheet Type'),
              value: Text(bookingSheet.sheet ?? ''),
            ),
            const SizedBox(height: 15),
            DetailsTile(
              title: const Text('Price'),
              value: Text(bookingSheet.quantity ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
