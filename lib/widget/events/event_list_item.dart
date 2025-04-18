import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/event_detail_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/date_time_formater.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_navigation_tile.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';
import 'package:ooo_fit/widget/styles/style_data_row.dart';

class EventListItem extends StatelessWidget {
  final EventService _eventService = GetIt.instance.get<EventService>();

  final Event event;
  final double itemWidth;

  EventListItem({super.key, required this.event, required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return PageNavigationTile(
      dstPage: EventDetailPage(eventId: event.id),
      child: SizedBox(
        width: itemWidth,
        child: LoadingStreamBuilder<(Event?, Outfit?, Map<String, Style>)>(
          stream: _eventService.getEventDetailByIdStream(event.id),
          builder: (context, eventData) {
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    if (event.name != null) Expanded(child: Text(event.name!)),
                    if (event.temperature?.icon != null)
                      event.temperature!.icon,
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyleDataRow(
                      items: eventData.$3.values.toList(),
                      inOneRow: 2,
                    ),
                    const SizedBox(height: 2.0),
                    Text(DateTimeFormatter(event.eventDatetime).formatTime()),
                    const SizedBox(height: 2.0),
                    if (event.place != null) Text(event.place!),
                    if (eventData.$2 != null)
                      OutfitListItem(outfit: eventData.$2!),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
