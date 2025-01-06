import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/util/helper_functions.dart';
import 'package:rxdart/rxdart.dart';

class PieceService {
  final DatabaseService<Piece> _pieceRepository;
  final StyleService _styleService;

  // TODO move to the filter service?
  final BehaviorSubject<String?> _placementFilterSubject =
      BehaviorSubject<String?>.seeded(null);

  PieceService(
    this._pieceRepository,
    this._styleService,
  );

  Stream<String?> get placementFilterStream => _placementFilterSubject.stream;

  String? get currentPlacementFilter => _placementFilterSubject.value;

  void updatePlacementFilter(String? newFilter) {
    _placementFilterSubject.add(newFilter);
    print("Placement: $newFilter, updated: $currentPlacementFilter");
  }

  Future<String?> savePiece({
    required String name,
    required PiecePlacement piecePlacement,
    required List<String> styleIds,
    required String imagePath,
  }) async {
    String? downloadLink = await uploadImage(imagePath);

    final Piece piece = Piece(
      id: '',
      name: name,
      piecePlacement: piecePlacement,
      styleIds: styleIds,
      imagePath: downloadLink!,
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
    String? downloadLink = await uploadImage(imagePath);
    //TODO: implement deleting the old versions of images

    if (downloadLink != null) {
      final newPiece = piece.copyWith(
        name: name,
        imagePath: downloadLink,
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
    return null;
  }

  Stream<List<Piece>> getAllPiecesStream() {
    return _pieceRepository.observeDocuments();
  }

  Stream<List<Piece>> getFilteredPiecesStream() {
    return Rx.combineLatest2(
      _placementFilterSubject.stream,
      _pieceRepository.observeDocuments(),
      (String? filter, List<Piece> pieces) {
        if (filter == null) {
          return pieces;
        }
        return pieces
            .where((piece) => piece.piecePlacement.label == filter)
            .toList();
      },
    );
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
