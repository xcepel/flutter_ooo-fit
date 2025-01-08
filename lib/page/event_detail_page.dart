import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/event_edit_page.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/date_time_formater.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_navigation_tile.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';
import 'package:ooo_fit/widget/styles/style_data_row.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId;
  final EventService _eventService = GetIt.instance.get<EventService>();

  EventDetailPage({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _eventService.getEventDetailByIdStream(eventId),
      builder: (context, eventData) {
        return Scaffold(
          appBar: CustomAppBar(
            title: eventData.$1?.name ?? '',
            actionButton: EditButton(
              editPage: EventEditPage(event: eventData.$1),
            ),
          ),
          body: ContentFrameDetail(
            children: [
              eventData.$1?.temperature != null
                  ? Row(
                      children: [
                        eventData.$1!.temperature!.icon,
                        Text(eventData.$1!.temperature!.label),
                      ],
                    )
                  : Text("Temperature of event - not filled"),
              SizedBox(height: 10),
              eventData.$3.isNotEmpty
                  ? StyleDataRow(items: eventData.$3.values.toList())
                  : Text("Style of event not - filled"),
              SizedBox(height: 10),
              _buildEventDetailRow(
                eventData.$1?.eventDatetime != null,
                "Date",
                DateTimeFormatter(eventData.$1!.eventDatetime).formatDate(),
              ),
              SizedBox(height: 10),
              _buildEventDetailRow(
                eventData.$1?.place != null,
                "Place",
                eventData.$1!.place,
              ),
              SizedBox(height: 10),
              eventData.$2 != null
                  ? Center(
                      child: PageNavigationTile(
                        dstPage: OutfitDetailPage(
                          outfitId: eventData.$2!.id,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: OutfitListItem(outfit: eventData.$2!),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No chosen outfit.',
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.events),
        );
      },
    );
  }

  Widget _buildEventDetailRow(bool condition, String label, String data) {
    return condition
        ? DescriptionLabel(
            label: label,
            value: data,
          )
        : DescriptionLabel(
            label: label,
            value: '---',
          );
  }
}
