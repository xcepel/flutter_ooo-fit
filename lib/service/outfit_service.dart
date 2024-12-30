import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:rxdart/rxdart.dart';

class OutfitService {
  final DatabaseService<Outfit> _outfitRepository;
  final StyleService _styleService;
  final PieceService _pieceService;

  const OutfitService(
    this._outfitRepository,
    this._styleService,
    this._pieceService,
  );

  Future<String?> saveOutfit({
    required String? name,
    required List<String>? pieceIds,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) async {
    String? error = validate(
        name: name,
        pieceIds: pieceIds,
        styleIds: styleIds,
        temperature: temperature);
    if (error != null) {
      return error;
    }

    final piece = Outfit(
      id: '',
      name: name,
      pieceIds: pieceIds!,
      styleIds: styleIds!,
      temperature: temperature!,
    );

    await _outfitRepository.add(piece);
    return null;
  }

  Future<String?> updateOutfit({
    required Outfit outfit,
    required String? name,
    required List<String>? pieceIds,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) async {
    String? error = validate(
        name: name,
        pieceIds: pieceIds,
        styleIds: styleIds,
        temperature: temperature);
    if (error != null) {
      return error;
    }

    final newPiece = outfit.copyWith(name: name);
    //TODO: implement and use update
    await _outfitRepository.setOrAdd(outfit.id, newPiece);
    return null;
  }

  String? validate({
    required String? name,
    required List<String>? pieceIds,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) {
    if (name == null ||
        (pieceIds == null || pieceIds.isEmpty) ||
        (styleIds == null || styleIds.isEmpty) ||
        temperature == null) {
      return 'All cells must contain a value';
    }

    return null;
  }

  Stream<List<Outfit>> getAllOutfitsStream() {
    return _outfitRepository.observeDocuments();
  }

  Stream<Outfit?> getOutfitByIdStream(String outfitId) {
    return _outfitRepository.observeDocument(outfitId);
  }

  // returns list of outfits and (styleId -> style), (pieceId -> piece) dictionaries
  Stream<(List<Outfit>, Map<String, Style>, Map<String, Piece>)>
      getOutfitsWithStylesAndPiecesStream() {
    final outfitsStream = getAllOutfitsStream();

    return outfitsStream.switchMap(
      (outfits) {
        final styleIds = outfits.expand((piece) => piece.styleIds).toSet();
        final stylesByIdStream = _styleService.getStylesByIdsStream(styleIds);

        final pieceIds = outfits.expand((piece) => piece.pieceIds).toSet();
        final piecesByIdStream = _pieceService.getPiecesByIdsStream(pieceIds);

        return Rx.combineLatest2(
          stylesByIdStream,
          piecesByIdStream,
          (Map<String, Style> styles, Map<String, Piece> pieces) => (
            outfits,
            styles,
            pieces,
          ),
        );
      },
    );
  }
}
