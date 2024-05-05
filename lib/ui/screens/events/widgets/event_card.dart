import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photographers_book/config/routes.dart';
import 'package:photographers_book/utils/helper.dart';

import '../../../../model/event.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function onRefresh;

  const EventCard({super.key, required this.event, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return CustomCard(
      shadowColor: Colors.black12,
      radius: 10,
      margin: const EdgeInsets.all(7.5),
      child: InkWell(
        onTap: () async {
          var res = await Navigator.pushNamed(
            context,
            Routes.eventDetails.setId(event.id.toString()),
          );
          if (res == null) true;
          onRefresh();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 15),
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
                      value: Text(
                        (event.bookingDetails?.name ?? 'NA').toCapitalized(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              DetailsTile(
                title: const Text('Mobile Number'),
                value: Text(event.bookingDetails?.mobile ?? 'NA'),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: DetailsTile(
                      title: const Text('Address'),
                      value: Text(
                        event.address ?? 'NA',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Image.asset(Images.left_arrow, width: 15, height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
