import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../model/event.dart';
import '../../../../resources/colors.dart';
import '../../events/widgets/event_card.dart';

class EventStrip extends StatefulWidget {
  final List<Event> events;
  final Function onRefresh;

  const EventStrip({super.key, required this.events, required this.onRefresh});

  @override
  State<EventStrip> createState() => _EventStripState();
}

class _EventStripState extends State<EventStrip> {
  PageController _controller = PageController();

  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ExpandablePageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              setState(() => _selected = value);
            },
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              var scale = _selected == index ? 1.0 : 0.8;
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: scale, end: scale),
                curve: Curves.fastOutSlowIn,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: IntrinsicHeight(
                      child: EventCard(
                        event: widget.events[index],
                        onRefresh: widget.onRefresh,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.events.length; i++)
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                elevation: 0,
                shape: const StadiumBorder(),
                color: i == _selected
                    ? MyColors.accentColor
                    : const Color(0xFFAEAEAE),
                child: const SizedBox(height: 6, width: 6),
              ),
          ],
        ),
      ],
    );
  }
}
