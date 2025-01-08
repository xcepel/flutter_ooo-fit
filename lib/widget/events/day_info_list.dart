import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/widget/common/ghost_card.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/events/event_list_item.dart';

class DayInfoList extends StatelessWidget {
  final EventService _eventService = GetIt.instance.get<EventService>();

  final DateTime date;

  DayInfoList({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width / 2 - 16;
    return LoadingStreamBuilder<List<Event>>(
        stream: _eventService.getEventsByDay(date),
        builder: (context, List<Event> eventsInDay) {
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
                  ...eventsInDay.map((event) =>
                      EventListItem(event: event, itemWidth: itemWidth)),
                  if (eventsInDay.length == 1) GhostCard(itemWidth: itemWidth),
                ],
              ),
            ),
          );
        });
  }
}
