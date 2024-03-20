import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../config/routes.dart';
import '../../../model/booking.dart';
import '../../../resources/images.dart';
import '../../widgets/details_tile.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/booking_widget.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String id;

  const BookingDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return FutureBuilder<Booking>(
      future: bookingBloc.getOneBooking(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var booking = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text('Booking Details')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                booking.name ?? 'NA',
                style: textTheme.titleMedium!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 15),
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
                      title: const Text('Due'),
                      value: Text('${booking.due ?? 'NA'}'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Amount Paid'),
                      value: Text('${booking.paid ?? 'NA'}'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Total Amount'),
                      value: Text('${booking.total ?? 'NA'}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Amount Payable'),
                      value: Text('${booking.payable ?? 'NA'}'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  if (booking.dueDate != null)
                    Expanded(
                      child: DetailsTile(
                        title: const Text('Due Date'),
                        value: Text(
                          DateFormat('MMMM dd, yyyy').format(booking.dueDate!),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 15),
              DetailsTile(
                title: const Text('Description'),
                value: Text(
                  booking.description ?? 'NA',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 25),
              BookingWidget(
                title: 'Event Details',
                image: Images.event_details,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '${Routes.bookingEvents}/${booking.id}',
                  );
                },
              ),
              const SizedBox(height: 15),
              BookingWidget(
                title: 'Album Details',
                image: Images.album_details,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '${Routes.bookingSheets}/${booking.id}',
                  );
                },
              ),
              const SizedBox(height: 15),
              BookingWidget(
                title: 'Payment Details',
                image: Images.payments,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '${Routes.bookingPayments}/${booking.id}',
                  );
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(width: 1, color: primaryColor),
                      textStyle: textTheme.titleMedium,
                    ),
                    onPressed: () async {},
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '${Routes.receivePayment}/$id/${booking.due}',
                      );
                    },
                    child: const Text('Receive Payment'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
