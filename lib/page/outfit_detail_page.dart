import 'package:flutter/material.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/clothes/clothes_items_list.dart';
import 'package:ooo_fit/widget/clothes/style_data_row.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class OutfitDetailPage extends StatelessWidget {
  final String name = "Outfit Name";
  final List<String> styles = [
    "Formal",
    "Goth",
    "Casual",
    "Sporty",
    "Vintage",
    "Bohemian",
    "Lively"
  ];
  final String temperature = "Warm";
  final String lastWorn = "1. 1. 1999";
  final String outfitPicture = "assets/images/levander_solid.jpg";

  OutfitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        actionButton: EditButton(editPage: OutfitEditPage()),
      ),
      body: ContentFrameDetail(
        children: [
          StyleDataRow(items: styles),
          SizedBox(height: 10),
          // Bude to tu vubec?, nechci to zarovnavat pokud to odstranime
          Row(
            children: [
              Icon(Icons.thermostat, color: Colors.blue),
              Text(temperature)
            ],
          ),
          SizedBox(height: 10),
          DescriptionLabel(
            label: "Last worn",
            value: lastWorn,
          ),
          SizedBox(height: 10),
          if (outfitPicture != null) _addOutfitPicture(outfitPicture),
          PageDivider(),
          SizedBox(height: 5),
          ClothesItemsList(),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }
}

Widget _addOutfitPicture(String outfitPicture) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double size = constraints.maxWidth;
      return SizedPicture(
        sizeX: size,
        sizeY: size * 1.3,
        image: outfitPicture,
      );
    },
  );
}
