import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/schedule_bloc.dart';
import '../../../../../resources/images.dart';

class ScheduleTopBar extends StatelessWidget {
  final ValueChanged<int> onRefresh;
  final int? selectedYear;
  final List<int> years;

  const ScheduleTopBar({
    Key? key,
    required this.onRefresh,
    this.selectedYear,
    required this.years,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var bloc = Provider.of<ScheduleBloc>(context);
    return Row(
      children: [
        const SizedBox(width: 8),
        BackButton(
          color: Colors.white,
          onPressed: () => Navigator.maybePop(context),
        ),
        const SizedBox(width: 8),
        Text(
          'My Events',
          style: textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            onPressed: () async {
              DropdownButton(
                value: selectedYear,
                onChanged: (dynamic value) => onRefresh(value),
                items: years.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList(),
              );
            },
            icon: Image.asset(
              Images.calendar,
              height: 20,
              color: Colors.white,
            ),
            label: Text(
              bloc.getYear(),
              style: textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
