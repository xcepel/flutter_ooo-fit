import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/widget/common/form/carousel.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfits/carousel_form_field.dart';
import 'package:ooo_fit/widget/outfits/picture_item.dart';

class OutfitBuilder extends StatelessWidget {
  final List<String>? selectedPieceIds;

  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  OutfitBuilder({
    super.key,
    this.selectedPieceIds,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _pieceService.getAllPiecesStream(),
      builder: (context, pieces) {
        return Column(
          children: PiecePlacement.values.map((PiecePlacement placement) {
            final List<Piece> piecesWithCurrentPlacement = pieces
                .where((Piece piece) => piece.piecePlacement == placement)
                .toList();

            final List<String>? selectedPiecesWithCurrentPlacementIds =
                selectedPieceIds
                    ?.where((id) => pieces.any((piece) =>
                        piece.id == id && piece.piecePlacement == placement))
                    .toList();

            return CarouselFormField(
              name: 'carousel_${placement.name}',
              multipleSelection: true,
              leading: Row(
                children: [
                  Image.asset(
                    placement.picture,
                    color: Colors.black,
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    placement.label,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              items: piecesWithCurrentPlacement
                  .map((Piece piece) => CarouselItem(
                        id: piece.id,
                        child: PictureItem(image: piece.imagePath),
                      ))
                  .toList(),
              selectedIds: selectedPiecesWithCurrentPlacementIds,
            );
          }).toList(),
        );
      },
    );
  }
}
