import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';
import 'package:ooo_fit/widget/outfit_piece/picture_changer.dart';
import 'package:ooo_fit/widget/outfit_piece/text_edit_label.dart';

class EventEditPage extends StatelessWidget {
  final String name = "Event 1";
  final String date = "1. 1. 1999, 20:00";
  final String place = "Brno";
  final String style = "Formal";
  final String temperature = "Cold";
  final String outfitName = "Outfit 1";
  final String outfitPhoto = "assets/images/test_picture.jpg";

  const EventEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: ContentFrameDetail(
        children: [
          TextEditLabel(label: "Date"),
          SizedBox(height: 10),
          TextEditLabel(label: "Place"),
          SizedBox(height: 10),
          TextEditLabel(label: "Style"),
          SizedBox(height: 10),
          TextEditLabel(label: "Temperature"),
          PageDivider(),
          // TODO dropdown/vyber ze strany/naseptavac?
          TextEditLabel(label: "Outfit"),
          SizedBox(height: 10),
          PictureChanger(image: outfitPhoto),
          PageDivider(),
          LabelButton(
            label: "Create/Edit",
            backgroundColor: Colors.transparent,
            textColor: Colors.deepPurple,
          ),
          SizedBox(height: 20),
          LabelButton(
            label: "Delete",
            backgroundColor: Colors.transparent,
            textColor: Colors.redAccent,
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.events),
    );
  }
}
