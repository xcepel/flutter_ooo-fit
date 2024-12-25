import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/clothes/style_data_row.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/list_item.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class ClothesDetailPage extends StatelessWidget {
  final String name = "Piece name";
  final List<String> styles = [
    "Casual",
    "Vintage",
  ];
  final String placement = "Placement type";
  final String lastWorn = "1. 1. 1999";
  final String clothingPicture = "assets/images/purple_solid.png";

  ClothesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        actionButton: EditButton(editPage: ClothesEditPage()),
      ),
      body: ContentFrameDetail(
        children: [
          StyleDataRow(items: styles),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.ice_skating_rounded), Text(placement)],
          ),
          SizedBox(height: 10),
          DescriptionLabel(
            label: "Last worn",
            value: lastWorn,
          ),
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;
              return SizedPicture(
                sizeX: size,
                sizeY: size,
                image: clothingPicture,
              );
            },
          ),
          PageDivider(),
          DescriptionLabel(label: "In outfits", value: ""),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListItem(text: "outfit$index");
            },
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.clothes),
    );
  }
}
