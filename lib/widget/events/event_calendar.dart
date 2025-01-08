import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/service/util/date_normalize.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatelessWidget {
  final EventService _eventService = GetIt.instance.get<EventService>();

  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime? selectedDay;
  final void Function(DateTime selectedDay, List<Event> events) onDaySelected;
  final void Function(CalendarFormat format) onFormatChanged;
  final void Function(DateTime focusedDay) onPageChanged;

  EventCalendar({
    super.key,
    required this.focusedDay,
    required this.calendarFormat,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder<Map<DateTime, List<Event>>>(
      stream: _eventService.getGroupedEventsStream(),
      builder: (context, Map<DateTime, List<Event>> eventData) {
        return TableCalendar(
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            onDaySelected(
              selectedDay,
              eventData[DateNormalize(selectedDay).normalize()] ?? [],
            );
          },
          onFormatChanged: onFormatChanged,
          onPageChanged: onPageChanged,
          eventLoader: (day) => eventData[DateNormalize(day).normalize()] ?? [],
        );
      },
    );
  }
}
