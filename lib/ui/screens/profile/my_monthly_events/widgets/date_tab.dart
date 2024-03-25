import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/schedule_bloc.dart';
import '../../../../widgets/custom_card.dart';

final dateFormatEEE = DateFormat('MMM');

class DateTabRow extends StatelessWidget {
  final VoidCallback onRefresh;

  const DateTabRow({Key? key, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var bloc = Provider.of<ScheduleBloc>(context);
    return SizedBox(
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bloc.months.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(7.5),
        itemBuilder: (BuildContext context, int index) {
          if (bloc.selected && bloc.selectedIndex == index) {
            return Column(
              children: [
                CustomCard(
                  radius: 5,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        bloc.months[index],
                        style: textTheme.titleSmall!.copyWith(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      bloc.selected = true;
                      bloc.month = bloc.months[index];
                      print('${bloc.month} ${bloc.selectedIndex}');
                      bloc.setIndex(index);
                      onRefresh();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      height: 1,
                      child: Text(
                        bloc.months[index],
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
