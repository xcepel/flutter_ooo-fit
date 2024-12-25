import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_detail_page.dart';
import 'package:ooo_fit/widget/clothes/clothes_list_item.dart';

class ClothesItemsList extends StatelessWidget {
  const ClothesItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          9,
          (itemIndex) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClothesDetailPage()),
              );
            },
            child: SizedBox(
              width: itemWidth,
              child: ClothesListItem(
                image: "assets/images/purple_solid.png",
                title: "Clothes $itemIndex",
                styleColors: [Colors.deepPurple, Colors.pinkAccent],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
