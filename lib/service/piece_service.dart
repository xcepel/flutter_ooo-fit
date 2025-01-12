import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/service/entity_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:rxdart/rxdart.dart';

class PieceService extends EntityService<Piece> {
  static const String errorStoreMessage =
      "There was a problem with saving the piece. Please try again.";

  final StyleService _styleService;

  PieceService(
    super.repository,
    super.authService,
    this._styleService,
  );

  Future<String?> savePiece({
    required String name,
    required PiecePlacement piecePlacement,
    required List<String> styleIds,
    required String imagePath,
  }) async {
    String? newImagePath = await uploadImage(imagePath);
    if (newImagePath == null) {
      return errorStoreMessage;
    }

    final Piece piece = Piece(
      id: '',
      userId: getCurrentUserId(),
      name: name,
      piecePlacement: piecePlacement,
      styleIds: styleIds,
      imagePath: newImagePath,
    );

    try {
      await repository.add(piece);
    } catch (e) {
      return errorStoreMessage;
    }
    return null;
  }

  Future<String?> updatePiece({
    required Piece piece,
    required String name,
    required PiecePlacement piecePlacement,
    required List<String> styleIds,
    required String imagePath,
  }) async {
    String? newImagePath = await uploadImage(imagePath);
    if (newImagePath == null) {
      return errorStoreMessage;
    }

    deleteImage(piece.imagePath);
    final newPiece = piece.copyWith(
      name: name,
      imagePath: newImagePath,
      styleIds: styleIds,
      piecePlacement: piecePlacement,
    );

    try {
      await repository.setOrAdd(piece.id, newPiece);
    } catch (e) {
      return errorStoreMessage;
    }
    return null;
  }

  @override
  Future<String?> delete(Piece piece) async {
    String? error = await super.delete(piece);
    if (error != null) {
      return error;
    }

    deleteImage(piece.imagePath);
    return null;
  }

  Stream<List<Piece>> getFilteredPiecesStream({
    Style? styleFilter,
    PiecePlacement? placementFilter,
    WearHistory? historySort,
  }) {
    return getAllStream().map((List<Piece> pieces) {
      final List<Piece> filteredPieces = pieces.where((piece) {
        final bool matchesStyle = styleFilter == null ||
            piece.styleIds.any((id) => id == styleFilter.id);
        final bool matchesPlacement =
            placementFilter == null || piece.piecePlacement == placementFilter;

        return matchesStyle && matchesPlacement;
      }).toList();

      if (historySort != null) {
        _sortPiecesByHistory(filteredPieces, historySort);
      }

      return filteredPieces;
    });
  }

  void _sortPiecesByHistory(List<Piece> pieces, WearHistory historyFilter) {
    final comparisonFactor = historyFilter == WearHistory.mostRecently ? -1 : 1;

    pieces.sort((a, b) {
      if (a.lastWorn == null && b.lastWorn == null) return 0;
      if (a.lastWorn == null) return -comparisonFactor; // null at bottom/top
      if (b.lastWorn == null) return comparisonFactor; // null at top/bottom
      return comparisonFactor * a.lastWorn!.compareTo(b.lastWorn!);
    });
  }

  Stream<Map<String, Piece>> getPiecesByIdsStream(Set<String> pieceIds) {
    return repository.observeDocumentsByIds(pieceIds).map(
      (pieces) {
        return {for (final piece in pieces) piece.id: piece};
      },
    );
  }

  Stream<(Piece?, Map<String, Style>)> getPieceDetailByIdStream(
      String pieceId) {
    final Stream<Piece?> pieceStream = getByIdStream(pieceId);

    return pieceStream.switchMap((Piece? piece) {
      if (piece == null) {
        return Stream.value((null, <String, Style>{}));
      }

      final Set<String> styleIds = piece.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getByIdsStream(styleIds);

      return stylesStream.map((styles) => (piece, styles));
    });
  }

  Stream<(List<Piece>, Map<String, Style>)> getPiecesWithStylesStream() {
    final piecesStream = getAllStream();

    return piecesStream.switchMap(
      (pieces) {
        final styleIds = pieces.expand((piece) => piece.styleIds).toSet();
        final stylesByIdStream = _styleService.getByIdsStream(styleIds);

        return stylesByIdStream.map((styles) => (pieces, styles));
      },
    );
  }
}
