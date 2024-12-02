import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';
import 'package:ooo_fit/widget/outfit_clothes/text_edit_label.dart';
import 'package:ooo_fit/widget/outfits/carousel.dart';
import 'package:ooo_fit/widget/outfits/placement_header_filter.dart';

class OutfitEditPage extends StatelessWidget {
  final String name = "Ratio Sorcerer";
  final String style = "Formal";
  final String temperature = "warm";

  const OutfitEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO just for testing
    final List<Map<String, String>> pictureItemsData = [
      {
        'image': "assets/images/test_clothes.jpg",
        'title': 'Stylish Outfit 1',
        'style': 'Casual wear',
        'lastWorn': '12th Aug',
      },
      {
        'image': "assets/images/test_clothes.jpg",
        'title': 'Formal Suit',
        'style': 'Business attire',
        'lastWorn': '5th Sep',
      },
      {
        'image': "assets/images/test_clothes.jpg",
        'title': 'Summer Dress',
        'style': 'Summer casual',
        'lastWorn': '20th Sep',
      },
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxWidth;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      // Grayscale picture
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: SizedPicture(
                        sizeX: size,
                        sizeY: size * 1.3,
                        image: "assets/images/test_picture.jpg",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Click to Change Picture"),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            TextEditLabel(label: "Style"), // TODO Naseptavani?
            SizedBox(height: 10),
            TextEditLabel(label: "Temperature"),
            PageDivider(),
            DescriptionLabel(label: "Consist of", value: ""),
            SizedBox(height: 10),
            PlacementHeaderFilter(label: "Head"),
            Carousel(pictureItemsData: pictureItemsData),
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
      ),
    );
  }
}
