import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/event_bloc.dart';
import '../../../config/routes.dart';
import '../../../model/event.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/dynamic_grid_view.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/events_strip.dart';
import 'widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    setState(() {});
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    future = Future.wait([eventBloc.getMonthlyEvents()]);
  }

  Future<List>? future;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: FutureBuilder<List>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var list = snapshot.data?[0] ?? [] as List<Event>;
          if (list.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Events in this month',
                  style: textTheme.titleSmall!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 10),
                CustomCard(
                  radius: 10,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Image.asset(Images.no_events, width: 100),
                        const SizedBox(height: 20),
                        Text(
                          'There are no Events in this month.\nClick + to add Event',
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      elevation: 0,
                      shape: StadiumBorder(),
                      color: MyColors.accentColor,
                      child: SizedBox(height: 6, width: 6),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                DynamicGridView(
                  spacing: 16,
                  count: 2,
                  children: [
                    HomeWidget(
                      image: Images.events_mine,
                      title: 'My\nEvents',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.myEvents);
                      },
                    ),
                    HomeWidget(
                      image: Images.my_bookings,
                      title: 'My\nBookings',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.myBookings);
                      },
                    )
                  ],
                )
              ],
            );
          }
          return ListView(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Events in this month',
                  style: textTheme.titleSmall!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              EventStrip(events: list, onRefresh: () => setState(() {})),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DynamicGridView(
                  spacing: 16,
                  count: 2,
                  children: [
                    HomeWidget(
                      image: Images.events_mine,
                      title: 'My\nEvents',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.myEvents);
                      },
                    ),
                    HomeWidget(
                      image: Images.my_bookings,
                      title: 'My\nBookings',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.myBookings);
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
