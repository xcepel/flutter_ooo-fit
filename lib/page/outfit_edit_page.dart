import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_changer.dart';
import 'package:ooo_fit/widget/outfit_clothes/text_edit_label.dart';
import 'package:ooo_fit/widget/outfits/carousel.dart';
import 'package:ooo_fit/widget/outfits/placement_header_filter.dart';

class OutfitEditPage extends StatelessWidget {
  final String name = "Ratio Sorcerer";
  final String style = "Formal";
  final String temperature = "warm";
  final String image = "assets/images/levander_solid.jpg";

  const OutfitEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO just for testing
    final List<String> pictureItemsData = [
      "assets/images/purple_solid.png",
      "assets/images/purple_solid.png",
      "assets/images/purple_solid.png",
    ];

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text("Style: "),
              ),
              SizedBox(width: 8),
              DropdownFilter(label: "Style"),
              SizedBox(width: 8),
              Checkbox(
                value: true, // if true turn of style dropdown
                onChanged: (bool? value) {},
                shape: CircleBorder(),
              ),
              Text("Generate from pieces"),
            ],
          ),
          SizedBox(height: 10),
          TextEditLabel(label: "Temperature"),
          SizedBox(height: 10),
          PictureChanger(image: image), // todo if no picture just button
          PageDivider(),
          PlacementHeaderFilter(
              label: "Head", iconType: Icons.headphones_sharp),
          Carousel(pictureItemsData: pictureItemsData),
          Carousel(pictureItemsData: pictureItemsData),
          SizedBox(height: 10),
          PlacementHeaderFilter(
              label: "Shoes", iconType: Icons.ice_skating_rounded),
          Carousel(pictureItemsData: pictureItemsData),
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
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }
}
