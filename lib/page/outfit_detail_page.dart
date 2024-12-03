import 'package:flutter/material.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/widget/clothes/clothes_items_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/page_content_frame.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/list_item.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class OutfitDetailPage extends StatelessWidget {
  final String name = "Ratio Sorcerer";
  final String style = "Formal";
  final String temperature = "Warm";
  final String lastWorn = "1. 1. 1999";

  const OutfitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        actionButton: EditButton(editPage: OutfitEditPage()),
      ),
      body: PageContentFrame(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;
              return SizedPicture(
                sizeX: size,
                sizeY: size * 1.3,
                image: "assets/images/test_picture.jpg",
              );
            },
          ),
          SizedBox(height: 10),
          DescriptionLabel(label: "Style", value: style),
          SizedBox(height: 10),
          DescriptionLabel(label: "Temperature", value: temperature),
          SizedBox(height: 10),
          DescriptionLabel(label: "Last worn", value: lastWorn),
          PageDivider(),
          DescriptionLabel(label: "Consists of", value: ""),
          SizedBox(height: 10),
          ClothesItemsList(),
          PageDivider(),
          DescriptionLabel(label: "Worn for", value: ""),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListItem(text: "event$index");
            },
          ),
        ],
      ),
    );
  }
}
