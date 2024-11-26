import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class ClothesDetail extends StatelessWidget {
  final String name = "Tie";
  final String placement = "Neck";
  final String style = "Formal";
  final String last_worn = "1. 1. 1999";

  const ClothesDetail({
    super.key,
  });

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
                    sizeX: size,
                    sizeY: size,
                    image: "assets/images/test_clothes.jpg");
              },
            ),
            SizedBox(height: 10),
            DescriptionLabel(label: "Placement", value: placement),
            SizedBox(height: 10),
            DescriptionLabel(label: "Style", value: style),
            SizedBox(height: 10),
            DescriptionLabel(label: "Last worn", value: last_worn),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Divider(color: Colors.deepPurple),
            ),
            DescriptionLabel(label: "In outfits", value: ""),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "- outfit$index",
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
