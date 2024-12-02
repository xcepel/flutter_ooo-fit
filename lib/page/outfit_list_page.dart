import 'package:flutter/material.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/four_part_filter_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_item.dart';

class OutfitListPage extends StatelessWidget {
  const OutfitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double idealColumnWidth = 190.0;
    int minColumns = 2;
    int maxColumns = 6;

    // Compute ideal column number based on size of screen
    int crossAxisCount = (screenWidth / idealColumnWidth).floor();
    crossAxisCount = crossAxisCount < minColumns ? minColumns : crossAxisCount;
    crossAxisCount = crossAxisCount > maxColumns ? maxColumns : crossAxisCount;

    // Dynamically adjust outfit item width and height
    double outfitItemWidth = screenWidth / crossAxisCount - 16;
    double outfitItemHeight = outfitItemWidth * 1.65;

    return Scaffold(
      appBar: CustomAppBar(title: "Outfit list"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FourPartFilterBar(
                filter1: "Style", filter2: "Weather", filter3: "Sort by"),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const AlwaysScrollableScrollPhysics(), // Enable scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: outfitItemWidth / outfitItemHeight,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OutfitDetailPage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: outfitItemWidth,
                      height: outfitItemHeight,
                      child: PictureItem(
                        image: "assets/images/test_picture.jpg",
                        title: "Outfit name $index",
                        style:
                            "A long description for the outfit that spans multiple lines.",
                        lastWorn: "1. 1. 1999",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
