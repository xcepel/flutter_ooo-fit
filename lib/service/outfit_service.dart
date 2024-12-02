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
      this._outfitRepository, this._styleService, this._pieceService);

  Future<String?> saveOutfit(
      {required String? name,
      required List<String>? pieceIds,
      required List<String>? styleIds,
      required TemperatureType? temperature}) async {
    if (name == null ||
        (pieceIds == null || pieceIds.isEmpty) ||
        (styleIds == null || styleIds.isEmpty) ||
        temperature == null) {
      return 'All cells must contain a value';
    }

    final piece = Outfit(
        id: '',
        name: name,
        pieceIds: pieceIds,
        styleIds: styleIds,
        temperature: temperature,
        isFavourite: false);

    await _outfitRepository.add(piece);
    return null;
  }

  Stream<List<Outfit>> getAllOutfitsStream() {
    return _outfitRepository.observeDocuments();
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
