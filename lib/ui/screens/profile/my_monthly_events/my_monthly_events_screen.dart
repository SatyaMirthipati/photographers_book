import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/schedule_bloc.dart';
import '../../../../resources/colors.dart';
import 'widgets/date_tab.dart';
import 'widgets/schedule_card.dart';
import 'widgets/schedule_top_bar.dart';

class MyMonthlyEventsScreen extends StatefulWidget {
  const MyMonthlyEventsScreen({Key? key}) : super(key: key);

  @override
  MyMonthlyEventsScreenState createState() => MyMonthlyEventsScreenState();
}

class MyMonthlyEventsScreenState extends State<MyMonthlyEventsScreen> {
  int? selectedYear;
  List<int> years = [];

  void generateYears() {
    var date = DateTime.now();
    selectedYear = date.year;
    for (int i = 2024; i <= date.year + 5; i++) {
      years.add(i);
    }
    print('Data&*$years');
  }

  @override
  void initState() {
    super.initState();
    generateYears();
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => ScheduleBloc(),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyColors.accentColor2, MyColors.accentColor],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: top + 8),
                  ScheduleTopBar(
                    selectedYear: selectedYear,
                    years: years,
                    onRefresh: (v) => setState(() {}),
                  ),
                  const SizedBox(height: 25),
                  DateTabRow(
                    onRefresh: () => setState(() {}),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            Expanded(child: ScheduleCard(key: ValueKey('$selectedYear'))),
          ],
        ),
      ),
    );
  }
}
