import 'package:flutter/material.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/widget/outfit_piece/bottom_data.dart';

class OutfitListItem extends StatelessWidget {
  // TODO remove
  final List<String> piecesImages = [
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
    "assets/images/purple_solid.png",
  ];

  final Outfit outfit;
  final List<Style> outfitStyles;

  OutfitListItem({
    super.key,
    required this.outfit,
    required this.outfitStyles,
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
                child: outfit.imagePath == null
                    ? _buildPiecesMatrix()
                    : _buildOutfitImage(),
              ),
            ),
            BottomData(styles: outfitStyles, temperature: outfit.temperature),
          ],
        ),
        const SizedBox(height: 5),
        Text(outfit.name ?? ""),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildOutfitImage() {
    return Image.network(
      outfit.imagePath!,
      fit: BoxFit.cover,
    );
  }

  // TODO tohle bude brat z pieces
  Widget _buildPiecesMatrix() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 2.7 / 2,
      ),
      itemCount:
          piecesImages.length > 9 ? 9 : piecesImages.length, // max 9 items
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            piecesImages[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
