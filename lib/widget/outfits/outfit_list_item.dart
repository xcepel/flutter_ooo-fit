import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfit_piece/bottom_data.dart';

class OutfitListItem extends StatelessWidget {
  final Outfit outfit;

  final StyleService _styleService = GetIt.instance.get<StyleService>();
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  static const int matrixImageCount = 6;

  OutfitListItem({
    super.key,
    required this.outfit,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder<Map<String, Style>>(
      stream: _styleService.getStylesByIdsStream(outfit.styleIds.toSet()),
      builder: (context, Map<String, Style> styles) {
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
                BottomData(
                  styles: styles.values.toList(),
                  temperature: outfit.temperature,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(outfit.name ?? ""),
            const SizedBox(height: 5),
          ],
        );
      },
    );
  }

  Widget _buildOutfitImage() {
    return Image.network(
      outfit.imagePath!,
      fit: BoxFit.cover,
    );
  }

  Widget _buildPiecesMatrix() {
    return LoadingStreamBuilder(
      stream: _pieceService.getPiecesByIdsStream(outfit.pieceIds.toSet()),
      builder: (context, pieces) {
        final int piecesCount = outfit.pieceIds.length;
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1,
          ),
          itemCount: min(piecesCount, matrixImageCount),
          itemBuilder: (context, index) {
            String currentPieceId = outfit.pieceIds[index];
            Piece currentPiece = pieces[currentPieceId]!;

            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                currentPiece.imagePath,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
