import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/bottom_style_dots.dart';

class ClothesListItem extends StatelessWidget {
  final String image;
  final String title;
  final List<Color> styleColors;

  const ClothesListItem({
    super.key,
    required this.image,
    required this.title,
    required this.styleColors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BottomStyleDots(styleColors: styleColors),
          ],
        ),
        const SizedBox(height: 5),
        Text(title),
        const SizedBox(height: 5),
      ],
    );
  }
}
