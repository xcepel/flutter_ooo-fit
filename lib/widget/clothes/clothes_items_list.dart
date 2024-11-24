import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_item.dart';

class ClothesItemsList extends StatelessWidget {
  const ClothesItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        5,
        (itemIndex) => SizedBox(
          width: 155,
          child: PictureItem(
            image: "assets/images/test_clothes.jpg",
            title: "Clothes $itemIndex",
            style: "Sample Style",
            lastWorn: "1. 1. 1999",
          ),
        ),
      ),
    );
  }
}
