import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/form/edit_form_wrapper.dart';
import 'package:ooo_fit/widget/events/event_edit_form.dart';

class EventEditPage extends StatelessWidget {
  final Event? event;
  final EventService _eventService = GetIt.instance.get<EventService>();

  EventEditPage({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ContentFrameDetail(
        children: [
          EditFormWrapper(
            onSaveSuccessMessage: "Event was saved successfully",
            onDeleteSuccessMessage: "Event was deleted successfully",
            onSave: handleSave,
            onDelete: event != null ? handleDelete : null,
            onDeleteNavigationPage: EventsListPage(),
            child: EventEditForm(
              event: event,
            ),
          )
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }

  Future<String?> handleDelete() async {
    return await _eventService.delete(event!);
  }

  Future<String?> handleSave(Map<String, dynamic> formData) async {
    final bool hideOutfitCarousel = formData['hideOutfitCarousel'];
    final String? outfitId =
        hideOutfitCarousel ? null : formData['outfitId'][0];

    if (event == null) {
      return await _eventService.saveEvent(
        name: formData['name'],
        styleIds: formData['styleIds'],
        place: formData['place'],
        temperature: formData['temperature'],
        outfitId: outfitId,
        eventDatetime: formData['datetime'],
      );
    } else {
      return await _eventService.updateEvent(
        event: event!,
        name: formData['name'],
        styleIds: formData['styleIds'],
        place: formData['place'],
        temperature: formData['temperature'],
        outfitId: outfitId,
        eventDatetime: formData['datetime'],
      );
    }
  }
}
