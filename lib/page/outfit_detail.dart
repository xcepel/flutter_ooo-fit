import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/clothes/clothes_items_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class OutfitDetail extends StatelessWidget {
  final String name = "Ratio Sorcerer";
  final String style = "Formal";
  final String temperature = "warm"; // todo chceme temperature nebo weather?
  final String last_worn = "1. 1. 1999";

  const OutfitDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxWidth;
                return SizedPicture(
                    // TODO probably change so it does not fill the whole page
                    sizeX: size,
                    sizeY: size * 1.3,
                    image: "assets/images/test_picture.jpg");
              },
            ),
            SizedBox(height: 10),
            DescriptionLabel(label: "Style", value: style),
            SizedBox(height: 10),
            DescriptionLabel(label: "Temperature", value: temperature),
            SizedBox(height: 10),
            DescriptionLabel(label: "Last worn", value: last_worn),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Divider(color: Colors.deepPurple),
            ),
            DescriptionLabel(label: "Consists of", value: ""),
            SizedBox(height: 10),
            ClothesItemsList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Divider(color: Colors.deepPurple),
            ),
            DescriptionLabel(label: "Worn for", value: ""),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "- event$index",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
