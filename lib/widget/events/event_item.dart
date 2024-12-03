import 'package:flutter/material.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/page/event_detail_page.dart';

class EventInfo extends StatelessWidget {
  final Event event;

  const EventInfo({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(
        'Place: ${event.place}\nTemperature: ${event.temperature?.label}\nStyle: Formal',
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailPage()),
        );
      },
    );
  }
}
