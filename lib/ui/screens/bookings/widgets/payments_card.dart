import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/booking_payments.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class PaymentsCard extends StatelessWidget {
  final BookingPayments bookingPayments;

  const PaymentsCard({super.key, required this.bookingPayments});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: 10,
      margin: const EdgeInsets.all(7.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: DetailsTile(
                title: const Text('Amount'),
                value: Text('${bookingPayments.amount ?? 'NA'}/-'),
              ),
            ),
            const SizedBox(width: 20),
            if (bookingPayments.date != null) ...[
              Expanded(
                child: DetailsTile(
                  title: const Text('Date'),
                  value: Text(
                    DateFormat('dd MMMM, yyyy').format(bookingPayments.date!),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
