import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfits/placement_piece_chooser.dart';

class OutfitBuilder extends StatelessWidget {
  List<String>? selectedPieceIds;

  OutfitBuilder({
    super.key,
    this.selectedPieceIds,
  });

  final PieceService _pieceService = GetIt.instance.get<PieceService>();

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

            return PlacementPieceChooser(
              piecePlacement: placement,
              piecesList: piecesWithCurrentPlacement,
              selectedIds: selectedPiecesWithCurrentPlacementIds,
            );
          }).toList(),
        );
      },
    );
  }
}
