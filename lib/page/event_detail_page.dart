import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/event_edit_page.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/date_time_formater.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/info_bubble.dart';
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
        Event event = eventData.$1!;
        Outfit? outfit = eventData.$2;
        Map<String, Style> styles = eventData.$3;

        return Scaffold(
          appBar: CustomAppBar(
            title: event.name ?? '',
            actionButton: EditButton(
              editPage: EventEditPage(event: event),
            ),
          ),
          body: ContentFrameDetail(
            children: [
              event.temperature != null
                  ? Row(
                      children: [
                        event.temperature!.icon,
                        Text(event.temperature!.label),
                      ],
                    )
                  : Text("Temperature of event - not filled"),
              SizedBox(height: 10),
              styles.isNotEmpty
                  ? StyleDataRow(items: styles.values.toList())
                  : Text("Style of event not - filled"),
              SizedBox(height: 10),
              _buildEventDetailRow(
                "Date",
                DateTimeFormatter(event.eventDatetime).formatDate(),
              ),
              SizedBox(height: 10),
              _buildEventDetailRow(
                "Place",
                event.place,
              ),
              SizedBox(height: 10),
              _buildOutfitSection(context, outfit),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.events),
        );
      },
    );
  }

  Widget _buildOutfitSection(BuildContext context, Outfit? outfit) {
    return outfit != null
        ? Center(
            child: PageNavigationTile(
              dstPage: OutfitDetailPage(
                outfitId: outfit.id,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: OutfitListItem(outfit: outfit),
              ),
            ),
          )
        : InfoBubble(
            message: "You haven't chosen an outfit yet! Do it now!",
          );
  }

  Widget _buildEventDetailRow(String label, String? data) {
    return data != null
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
