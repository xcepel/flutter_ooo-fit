import 'package:flutter/material.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/events/event_edit_form.dart';

class EventEditPage extends StatelessWidget {
  final Event? event;

  const EventEditPage({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: ContentFrameDetail(
        children: [EventEditForm(event: event)],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }
}
