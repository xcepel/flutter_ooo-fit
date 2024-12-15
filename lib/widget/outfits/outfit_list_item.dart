import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/bottom_style_dots.dart';

class OutfitListItem extends StatelessWidget {
  final List<String> clothesImages = [
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
  ];

  final String? outfitImage;
  final String title;
  final List<Color> styleColors;

  OutfitListItem({
    super.key,
    required this.outfitImage,
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
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: outfitImage == null
                    ? _buildClothesMatrix()
                    : _buildOutfitImage(),
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

  Widget _buildOutfitImage() {
    return Image.network(
      outfitImage!,
      fit: BoxFit.cover,
    );
  }

  Widget _buildClothesMatrix() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 2.7 / 2,
      ),
      itemCount: clothesImages.length > 9
          ? 9
          : clothesImages.length, // Show max 9 items
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            clothesImages[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
