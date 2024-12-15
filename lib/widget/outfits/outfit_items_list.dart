import 'package:flutter/material.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';
import 'dart:math';

class OutfitItemsList extends StatelessWidget {
  const OutfitItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            9,
            (itemIndex) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OutfitDetailPage()),
                );
              },
              child: SizedBox(
                width: itemWidth,
                child: OutfitListItem(
                  // TODO remove, here just for showing
                  outfitImage: Random().nextBool()
                      ? "assets/images/levander_solid.jpg"
                      : null,
                  title: "Outfit $itemIndex",
                  styleColors: [Colors.deepPurple, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
