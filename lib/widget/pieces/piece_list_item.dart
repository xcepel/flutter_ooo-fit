import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/widget/common/downloaded_image.dart';
import 'package:ooo_fit/widget/outfit_piece/list_item_card.dart';

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
    return ListItemCard(
      name: piece.name,
      styles: pieceStyles,
      piecePlacement: piece.piecePlacement,
      image: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: DownloadedImage(
            imagePath: piece.imagePath,
          ),
        ),
      ),
    );
  }
}
