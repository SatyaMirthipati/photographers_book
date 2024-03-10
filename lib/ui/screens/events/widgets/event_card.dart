import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/event.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: CustomCard(
        shadowColor: Colors.black12,
        radius: 10,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        value: Text(event.bookingDetails?.name ?? 'NA'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                DetailsTile(
                  title: const Text('Address'),
                  value: Text(
                    event.address ?? 'NA',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(Images.left_arrow, width: 15, height: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
