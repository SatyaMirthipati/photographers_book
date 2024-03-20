import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/event_bloc.dart';
import 'package:photographers_book/model/event.dart';
import 'package:photographers_book/ui/screens/events/widgets/event_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class BookingEventsScreen extends StatefulWidget {
  final String bookingId;

  const BookingEventsScreen({super.key, required this.bookingId});

  @override
  State<BookingEventsScreen> createState() => _BookingEventsScreenState();
}

class _BookingEventsScreenState extends State<BookingEventsScreen> {
  @override
  Widget build(BuildContext context) {
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Event Details')),
      body: FutureBuilder<List<Event>>(
        future: eventBloc.getEvents(query: {'bookingId': widget.bookingId}),
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
              return EventCard(
                event: list[index],
                onRefresh: () => setState(() {}),
              );
            },
          );
        },
      ),
    );
  }
}
