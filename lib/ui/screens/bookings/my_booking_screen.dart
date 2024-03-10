import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photographers_book/bloc/booking_bloc.dart';
import 'package:photographers_book/model/booking.dart';
import 'package:photographers_book/ui/screens/bookings/widgets/booking_card.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  final searchSubject = BehaviorSubject<String>();
  final searchCtrl = TextEditingController();
  Stream<String>? searchStream;

  void onSearch(String value) {
    searchSubject.add(value);
  }

  @override
  void dispose() {
    searchSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchStream = searchSubject.debounceTime(
      const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: StreamBuilder<String>(
        stream: searchStream,
        builder: (context, snapshot) {
          var search = snapshot.data ?? '';
          return FutureBuilder<List<Booking>>(
            future: bookingBloc.getAllBookings(query: {'search': search}),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return CustomErrorWidget(error: snapshot.error);
              }
              if (!snapshot.hasData) return const LoadingWidget();
              var list = snapshot.data ?? [];
              if (list.isEmpty) const EmptyWidget();
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: TextFormField(
                      onChanged: onSearch,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9a-zA-Z]'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Search for booking',
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return BookingCard(booking: list[index]);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
