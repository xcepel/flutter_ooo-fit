import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:rxdart/rxdart.dart';

class PieceService {
  final DatabaseService<Piece> _pieceRepository;
  final StyleService _styleService;

  const PieceService(
    this._pieceRepository,
    this._styleService,
  );

  Future<String?> savePiece({
    required String? name,
    required PiecePlacement? piecePlacement,
    required List<String>? styleIds,
  }) async {
    String? error = validate(
        name: name, piecePlacement: piecePlacement, styleIds: styleIds);
    if (error != null) {
      return error;
    }

    final piece = Piece(
      id: '',
      name: name!,
      piecePlacement: piecePlacement!,
      styleIds: styleIds!,
    );

    await _pieceRepository.add(piece);
    return null;
  }

  Future<String?> updatePiece({
    required Piece piece,
    required String? name,
    required PiecePlacement? piecePlacement,
    required List<String>? styleIds,
  }) async {
    String? error = validate(
        name: name, piecePlacement: piecePlacement, styleIds: styleIds);
    if (error != null) {
      return error;
    }

    final newPiece = piece.copyWith(name: name);
    //TODO: implement and use update
    await _pieceRepository.setOrAdd(piece.id, newPiece);
    return null;
  }

  String? validate({
    required String? name,
    required PiecePlacement? piecePlacement,
    required List<String>? styleIds,
  }) {
    if (name == null ||
        piecePlacement == null ||
        (styleIds == null || styleIds.isEmpty)) {
      return 'All cells must contain a value';
    }

    // // check if piecePlacement value is part of the enum
    // try {
    //   PiecePlacement.values.byName(piecePlacement);
    // } catch (e) {
    //   return 'Invalid piece placement value';
    // }

    return null;
  }

  Stream<List<Piece>> getAllPiecesStream() {
    return _pieceRepository.observeDocuments();
  }

  Stream<Map<String, Piece>> getPiecesByIdsStream(Set<String> pieceIds) {
    return _pieceRepository.observeDocumentsByIds(pieceIds).map(
      (pieces) {
        return {for (final piece in pieces) piece.id: piece};
      },
    );
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
