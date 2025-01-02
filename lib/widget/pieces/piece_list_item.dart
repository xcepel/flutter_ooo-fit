import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/widget/outfit_piece/bottom_data.dart';

class PieceListItem extends StatelessWidget {
  final Piece piece;
  final List<Style> pieceStyles;

  const PieceListItem({
    super.key,
    required this.piece,
    required this.pieceStyles,
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
                  piece.imagePath ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BottomData(styles: pieceStyles, placement: piece.piecePlacement),
          ],
        ),
        const SizedBox(height: 5),
        Text(piece.name),
        const SizedBox(height: 5),
      ],
    );
  }
}
