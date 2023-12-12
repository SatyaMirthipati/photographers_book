import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/dynamic_grid_view.dart';
import 'widgets/home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      'There are no Events in this month.\nclick + to add Event',
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
                  image: Images.upcoming_events,
                  title: 'Upcoming\nEvents',
                  onTap: () {},
                ),
                HomeWidget(
                  image: Images.completed_events,
                  title: 'Completed\nEvents',
                  onTap: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
