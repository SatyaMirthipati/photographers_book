import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/event_bloc.dart';
import '../../../../../bloc/schedule_bloc.dart';
import '../../../../../model/event.dart';
import '../../../../../resources/colors.dart';
import '../../../../../resources/images.dart';
import '../../../../widgets/empty_widget.dart';
import '../../../../widgets/error_widget.dart';
import '../../../../widgets/loading_widget.dart';

class ScheduleCard extends StatelessWidget {
  final String? dateTime;

  const ScheduleCard({Key? key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    var bloc = Provider.of<ScheduleBloc>(context, listen: false);
    print(dateTime);
    return FutureBuilder<List<Event>>(
      future: eventBloc.getEvents(
        query: {
          'month':
              '2024-${bloc.selectedIndex < 9 ? '0${bloc.selectedIndex + 1}' : bloc.selectedIndex + 1}'
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) return CustomErrorWidget(error: snapshot.error);
        if (!snapshot.hasData) return const LoadingWidget();
        var list = snapshot.data ?? [];
        if (list.isEmpty) {
          return const EmptyWidget(
            message: 'There are no Events in\nthis period',
            image: Images.no_events,
            size: 200,
          );
        }
        return ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: MyColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${list[index].event}',
                      style: textTheme.titleSmall!.copyWith(fontSize: 16),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.statusColor[list[index].status]
                            ?.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          '${list[index].status}',
                          style: textTheme.titleSmall!.copyWith(
                            color: MyColors.statusColor[list[index].status],
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
