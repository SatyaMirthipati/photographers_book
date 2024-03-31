import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photographers_book/ui/screens/bookings/edit_booking/edit_albums_screen.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/booking.dart';
import '../../../../model/category.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/navbar_button.dart';
import 'edit_booking_event_screen.dart';

class EditEventsScreen extends StatefulWidget {
  final Map<String, dynamic> response;
  final List<Category> categories;
  final Booking booking;

  const EditEventsScreen({
    super.key,
    required this.response,
    required this.categories,
    required this.booking,
  });

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
    required List<Category> categories,
    required Booking booking,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditEventsScreen(
          response: response,
          categories: categories,
          booking: booking,
        ),
      ),
    );
  }

  @override
  State<EditEventsScreen> createState() => _EditEventsScreenState();
}

class _EditEventsScreenState extends State<EditEventsScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (bookingBloc.updateEventsData.isNotEmpty) ...[
              Text(
                'Event Details Added',
                style: textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < bookingBloc.updateEventsData.length; i++) ...[
                CustomCard(
                  margin: EdgeInsets.zero,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DetailsTile(
                                    title: const Text('Event'),
                                    value: Text(
                                      bookingBloc.updateEventsData[i].event ??
                                          'NA',
                                    ),
                                  ),
                                ),
                                if (bookingBloc.updateEventsData[i].date !=
                                    null) ...[
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Date'),
                                      value: Text(
                                          DateFormat('yyyy MMM, dd').format(
                                        bookingBloc.updateEventsData[i].date!,
                                      )),
                                    ),
                                  ),
                                ],
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 15),
                            DetailsTile(
                              title: const Text('Address'),
                              value: Text(
                                bookingBloc.updateEventsData[i].address ?? 'NA',
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: DetailsTile(
                                    title: const Text('Camera'),
                                    value: Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        for (var item in bookingBloc
                                                .updateEventsData[i].camera ??
                                            [])
                                          Text('${item ?? 'NA'},'),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: DetailsTile(
                                    title: const Text('Drone'),
                                    value: Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        for (var item in bookingBloc
                                                .updateEventsData[i].drone ??
                                            [])
                                          Text('${item ?? 'NA'},'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            DetailsTile(
                              title: const Text('Video'),
                              value: Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  for (var item in bookingBloc
                                          .updateEventsData[i].video ??
                                      [])
                                    Text('${item ?? 'NA'},'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (i != 0)
                          Positioned(
                            top: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  bookingBloc.updateEventsData.remove(
                                    bookingBloc.updateEventsData[i],
                                  );
                                });
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.redAccent.shade700,
                                size: 20,
                              ),
                            ),
                          ),
                        Positioned(
                          top: i != 0 ? 15 : -15,
                          right: -15,
                          child: IconButton(
                            onPressed: () async {
                              var res = await EditBookingEventScreen.open(
                                context,
                                bookingsEvents: bookingBloc.updateEventsData[i],
                                index: i,
                                categories: widget.categories,
                              );
                              if (res == null) return;
                              setState(() {});
                            },
                            icon: Image.asset(
                              Images.edit,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ]
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          var response = widget.response;
          response['events'] = bookingBloc.updateEventsData.map(
            (e) => e.toMap(),
          ).toList();

          EditAlbumsScreen.open(
            context,
            response: response,
            booking: widget.booking,
          );
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
