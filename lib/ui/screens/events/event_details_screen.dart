import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../bloc/event_bloc.dart';
import '../../../model/event.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/details_tile.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  final String id;

  const EventDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var style = textTheme.titleSmall!.copyWith(
      color: Colors.black.withOpacity(0.5),
      fontSize: 12,
    );
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black.withOpacity(0.2)),
            ),
            onSelected: (item) {
              if (item == 'edit') {}
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.more_vert),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Image.asset(Images.edit, width: 20, height: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Edit Event Details',
                        style: textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<Event>(
        future: eventBloc.getOneEvent(id: id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var event = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  DetailsTile(
                    title: const Text('Event'),
                    value: Text(event.event ?? 'NA'),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: event.status == 'PENDING'
                          ? MyColors.pending.withOpacity(0.2)
                          : MyColors.completed.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${event.status}',
                      style: textTheme.titleMedium!.copyWith(
                        color: event.status == 'PENDING'
                            ? MyColors.pending
                            : MyColors.completed,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  if (event.date != null) ...[
                    Expanded(
                      child: DetailsTile(
                        title: const Text('Date'),
                        value: Text(
                          DateFormat('dd MMMM, yyyy').format(event.date!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Client Name'),
                      value: Text(event.bookingDetails?.name ?? 'NA'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Mobile Number'),
                      value: Text(event.bookingDetails?.mobile ?? 'NA'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Event type'),
                      value: Text(event.event ?? 'NA'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DetailsTile(
                title: const Text('Address'),
                value: Text(
                  event.address ?? 'NA',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 20),
              Text('Video', style: style),
              const SizedBox(height: 5),
              ContainerWidget(title: event.video ?? 'NA'),
              const SizedBox(height: 20),
              Text('Camera', style: style),
              const SizedBox(height: 5),
              ContainerWidget(title: event.camera ?? 'NA'),
              const SizedBox(height: 20),
              Text('Drone', style: style),
              const SizedBox(height: 5),
              ContainerWidget(title: event.drone ?? 'NA')
            ],
          );
        },
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String title;

  const ContainerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 10,
            ),
            child: Text(title, style: textTheme.titleMedium),
          ),
        ),
      ],
    );
  }
}
