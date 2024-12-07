import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/constants.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/page/event_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/events/event_item.dart';
import 'package:table_calendar/table_calendar.dart';

//TODO: refactor and break into widgets
class EventsListPage extends StatefulWidget {
  //TODO: create reasonable constants
  static final kToday = DateTime.now();
  static final kFirstDay = DateTime(2010, 1, 1);
  static final kLastDay = DateTime(2025, 12, 31);

  late LinkedHashMap<DateTime, List<Event>> kEvents;
  late Map<DateTime, List<Event>> _kEventSource;

  EventsListPage({super.key}) {
    _kEventSource = {
      DateTime(2024, 12, 4): [
        Event(
          id: '',
          name: 'School',
          eventDatetime: DateTime(2024, 12, 4),
          outfitId: null,
          place: 'Brno',
          styleIds: [],
          temperature: TemperatureType.cold,
          createdAt: DateTime(2024, 12, 2),
        ),
        Event(
          id: '',
          name: 'Date',
          eventDatetime: DateTime(2024, 12, 4),
          outfitId: null,
          place: 'Brno',
          styleIds: [],
          temperature: TemperatureType.cold,
          createdAt: DateTime(2024, 12, 2),
        )
      ],
      DateTime(2024, 12, 10): [
        Event(
          id: '',
          name: 'Work',
          eventDatetime: DateTime(2024, 12, 10),
          outfitId: null,
          place: 'Brno',
          styleIds: [],
          temperature: TemperatureType.cold,
          createdAt: DateTime(2024, 12, 2),
        ),
      ],
      DateTime(2024, 12, 8): [
        Event(
          id: '',
          name: 'Party',
          eventDatetime: DateTime(2024, 12, 8),
          outfitId: null,
          place: 'Brno',
          styleIds: [],
          temperature: TemperatureType.warm,
          createdAt: DateTime(2024, 12, 2),
        ),
      ],
    };

    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
    )..addAll(_kEventSource);
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents.entries
        .where((entry) => isSameDay(entry.key, day))
        .expand((entry) => entry.value)
        .toList();
  }

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Events list'),
      body: Column(
        children: [
          _buildEventCalendar(),
          _buildEventListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EventEditPage()));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }

  Widget _buildEventCalendar() {
    return TableCalendar(
      firstDay: EventsListPage.kFirstDay,
      lastDay: EventsListPage.kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      eventLoader: widget._getEventsForDay,
    );
  }

  Widget _buildEventListView() {
    return Expanded(
      child: ListView.builder(
        padding: pagePadding,
        itemCount: widget
            ._getEventsForDay(_selectedDay ?? EventsListPage.kToday)
            .length,
        itemBuilder: (context, index) {
          final event = widget
              ._getEventsForDay(_selectedDay ?? EventsListPage.kToday)[index];
          return EventInfo(event: event);
        },
      ),
    );
  }
}
