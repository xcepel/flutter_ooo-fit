import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:rxdart/rxdart.dart';

class PieceService {
  final DatabaseService<Piece> _pieceRepository;
  final StyleService _styleService;

  PieceService(
    this._pieceRepository,
    this._styleService,
  );

  Future<String?> savePiece({
    required String name,
    required PiecePlacement piecePlacement,
    required List<String> styleIds,
    required String imagePath,
  }) async {
    String? newImagePath = await uploadImage(imagePath);

    final Piece piece = Piece(
      id: '',
      name: name,
      piecePlacement: piecePlacement,
      styleIds: styleIds,
      imagePath: newImagePath!,
    );

    await _pieceRepository.add(piece);
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

    if (newImagePath != null) {
      deleteImage(piece.imagePath);
      final newPiece = piece.copyWith(
        name: name,
        imagePath: newImagePath,
        styleIds: styleIds,
        piecePlacement: piecePlacement,
      );
      //TODO: implement and use update
      await _pieceRepository.setOrAdd(piece.id, newPiece);
      return null;
    }

    return 'Error while uploading the image';
  }

  Future<String?> deletePiece({required Piece piece}) async {
    await _pieceRepository.delete(piece.id);
    await deleteImage(piece.imagePath);

    return null;
  }

  Stream<List<Piece>> getAllPiecesStream() {
    return _pieceRepository.observeDocuments();
  }

  Stream<List<Piece>> getFilteredPiecesStream({
    Style? styleFilter,
    PiecePlacement? placementFilter,
    WearHistory? historySort,
  }) {
    return getAllPiecesStream().map((List<Piece> pieces) {
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

  Stream<Piece?> getPieceByIdStream(String pieceId) {
    return _pieceRepository.observeDocument(pieceId);
  }

  Stream<Map<String, Piece>> getPiecesByIdsStream(Set<String> pieceIds) {
    return _pieceRepository.observeDocumentsByIds(pieceIds).map(
      (pieces) {
        return {for (final piece in pieces) piece.id: piece};
      },
    );
  }

  Stream<(Piece?, Map<String, Style>)> getPieceDetailByIdStream(
      String pieceId) {
    final Stream<Piece?> pieceStream = getPieceByIdStream(pieceId);

    return pieceStream.switchMap((Piece? piece) {
      if (piece == null) {
        return Stream.value((null, <String, Style>{}));
      }

      final Set<String> styleIds = piece.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getStylesByIdsStream(styleIds);

      return stylesStream.map((styles) => (piece, styles));
    });
  }

  Stream<(List<Piece>, Map<String, Style>)> getPiecesWithStylesStream() {
    final piecesStream = getAllPiecesStream();

    return piecesStream.switchMap(
      (pieces) {
        final styleIds = pieces.expand((piece) => piece.styleIds).toSet();
        final stylesByIdStream = _styleService.getStylesByIdsStream(styleIds);

        return stylesByIdStream.map((styles) => (pieces, styles));
      },
    );
  }
}
