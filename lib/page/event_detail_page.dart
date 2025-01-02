import 'package:flutter/material.dart';
import 'package:ooo_fit/page/event_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfit_piece/sized_picture.dart';

class EventDetailPage extends StatelessWidget {
  final String name = "Event 1";
  final String date = "1. 1. 1999, 20:00";
  final String place = "Brno";
  final String style = "Formal";
  final String temperature = "Cold";
  final String outfitName = "Outfit 1";
  final String outfitPhoto = "assets/images/test_picture.jpg";

  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: name, actionButton: EditButton(editPage: EventEditPage())),
      body: ContentFrameDetail(
        children: [
          DescriptionLabel(label: "Date", value: date),
          SizedBox(height: 10),
          DescriptionLabel(label: "Place", value: place),
          SizedBox(height: 10),
          DescriptionLabel(label: "Style", value: style),
          SizedBox(height: 10),
          DescriptionLabel(label: "Temperature", value: temperature),
          PageDivider(),
          DescriptionLabel(label: "Outfit", value: outfitName),
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;
              return SizedPicture(
                sizeX: size,
                sizeY: size * 1.3,
                image: outfitPhoto,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }
}
