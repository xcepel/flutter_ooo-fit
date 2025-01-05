import 'package:flutter/material.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/widget/common/ghost_card.dart';
import 'package:ooo_fit/widget/events/event_item.dart';

class DayInfoList extends StatelessWidget {
  final List<Event> eventsInDay;

  const DayInfoList({super.key, required this.eventsInDay});

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width / 2 - 16;

    if (eventsInDay.isEmpty) {
      return const Text(
        'No events for this day.',
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            ...eventsInDay
                .map((event) => EventItem(event: event, itemWidth: itemWidth)),
            if (eventsInDay.length == 1) GhostCard(itemWidth: itemWidth),
          ],
        ),
      ),
    );
  }
}
