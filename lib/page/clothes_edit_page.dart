import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_changer.dart';
import 'package:ooo_fit/widget/outfit_clothes/text_edit_label.dart';

class ClothesEditPage extends StatelessWidget {
  final String name = "Tie";
  final String placement = "Neck";
  final List<String> styles = [
    "Casual",
    "Vintage",
  ];
  final String picture = "assets/images/purple_solid.png";

  ClothesEditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter name',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
      body: ContentFrameDetail(
        children: [
          TextEditLabel(label: "Style"),
          SizedBox(height: 10),
          TextEditLabel(label: "Placement"),
          SizedBox(height: 10),
          PictureChanger(image: picture),
          PageDivider(),
          LabelButton(
            label: "Save",
            backgroundColor: Colors.transparent,
            textColor: Colors.deepPurple,
          ),
          SizedBox(height: 20),
          LabelButton(
            label: "Delete",
            backgroundColor: Colors.transparent,
            textColor: Colors.grey,
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.clothes),
    );
  }
}
