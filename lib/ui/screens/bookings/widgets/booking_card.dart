import 'package:flutter/material.dart';

import '../../../../config/routes.dart';
import '../../../../model/booking.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return CustomCard(
      radius: 10,
      margin: const EdgeInsets.all(7.5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.bookingDetails.setId(booking.id.toString()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Text(
                    booking.name ?? 'NA',
                    style: textTheme.titleMedium!.copyWith(fontSize: 20),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(Images.edit, width: 20, height: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DetailsTile(
                          title: const Text('Mobile Number'),
                          value: Text(booking.mobile ?? 'NA'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DetailsTile(
                          title: const Text('Address'),
                          value: Text(
                            booking.address ?? 'NA',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(
                        width: 1,
                        color: MyColors.primaryColor,
                      ),
                      textStyle: textTheme.titleMedium,
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        '${Routes.receivePayment}/${booking.id}/${booking.due}',
                      );
                    },
                    child: const Text('Make Payment'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
