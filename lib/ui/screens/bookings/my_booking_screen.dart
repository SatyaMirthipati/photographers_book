import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../bloc/user_bloc.dart';
import '../../../model/booking.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/booking_card.dart';

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
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: ListView(
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
          StreamBuilder<String>(
            stream: searchStream,
            builder: (context, snapshot) {
              var search = snapshot.data ?? '';
              return FutureBuilder<List<Booking>>(
                future: bookingBloc.getAllBookings(
                  query: {'search': search, 'userId': userBloc.profile.id},
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CustomErrorWidget(error: snapshot.error);
                  }
                  if (!snapshot.hasData) return const LoadingWidget();
                  var list = snapshot.data ?? [];
                  if (list.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3 - 50,
                        ),
                        const EmptyWidget(
                          message: 'There are no bookings to show',
                          size: 150,
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return BookingCard(booking: list[index]);
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
