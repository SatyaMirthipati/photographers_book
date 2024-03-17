import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../model/booking_payments.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/payments_card.dart';

class BookingPaymentsScreen extends StatelessWidget {
  final String bookingId;

  const BookingPaymentsScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Details')),
      body: FutureBuilder<List<BookingPayments>>(
        future: bookingBloc.getBookingPayments(query: {'bookingId': bookingId}),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var list = snapshot.data ?? [];
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return PaymentsCard(bookingPayments: list[index]);
            },
          );
        },
      ),
    );
  }
}
