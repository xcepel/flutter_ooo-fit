import 'package:flutter/material.dart';
import 'package:ooo_fit/page/event_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/page_formating/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/events/day_info_list.dart';
import 'package:ooo_fit/widget/events/event_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calendar',
        userMenu: true,
        weather_info: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            _buildEventCalendar(),
            PageDivider(),
            DayInfoList(date: _selectedDay),
          ],
        ),
      ),
      floatingActionButton: CreationFloatingButton(page: EventEditPage()),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }

  Widget _buildEventCalendar() {
    return EventCalendar(
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDay: _selectedDay,
      onDaySelected: (selectedDay, events) {
        setState(() {
          _selectedDay = selectedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
    );
  }
}
