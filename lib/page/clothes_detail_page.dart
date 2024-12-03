import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_edit_page.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/page_content_frame.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/list_item.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class ClothesDetailPage extends StatelessWidget {
  final String name = "Tie";
  final String placement = "Neck";
  final String style = "Formal";
  final String lastWorn = "1. 1. 1999";

  const ClothesDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        actionButton: EditButton(editPage: ClothesEditPage()),
      ),
      body: PageContentFrame(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;
              return SizedPicture(
                sizeX: size,
                sizeY: size,
                image: "assets/images/test_clothes.jpg",
              );
            },
          ),
          SizedBox(height: 10),
          DescriptionLabel(label: "Placement", value: placement),
          SizedBox(height: 10),
          DescriptionLabel(label: "Style", value: style),
          SizedBox(height: 10),
          DescriptionLabel(label: "Last worn", value: lastWorn),
          PageDivider(),
          DescriptionLabel(label: "In outfits", value: ""),
          SizedBox(height: 10),
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
    );
  }
}
