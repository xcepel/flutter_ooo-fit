import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/model/wear_history.dart';
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
    required String name,
    required List<String> pieceIds,
    required List<String> styleIds,
    required TemperatureType temperature,
    required String? imagePath,
  }) async {
    final piece = Outfit(
      id: '',
      name: name,
      pieceIds: pieceIds,
      styleIds: styleIds,
      temperature: temperature,
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
    required String? imagePath,
  }) async {
    final newPiece = outfit.copyWith(name: name);
    //TODO: implement and use update
    await _outfitRepository.setOrAdd(outfit.id, newPiece);
    return null;
  }

  Future<String?> deleteOutfit({required Outfit outfit}) async {
    await _outfitRepository.delete(outfit.id);
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
      getFilteredOutfitsWithStylesAndPiecesStream({
    Style? styleFilter,
    TemperatureType? temperatureFilter,
    WearHistory? historySort,
  }) {
    return _getFilteredOutfitsStream(
      styleFilter: styleFilter,
      temperatureFilter: temperatureFilter,
      historySort: historySort,
    ).switchMap((List<Outfit> filteredOutfits) {
      final Set<String> styleIds =
          filteredOutfits.expand((outfit) => outfit.styleIds).toSet();
      final Set<String> pieceIds =
          filteredOutfits.expand((outfit) => outfit.pieceIds).toSet();

      final Stream<Map<String, Style>> stylesByIdStream =
          _styleService.getStylesByIdsStream(styleIds);
      final Stream<Map<String, Piece>> piecesByIdStream =
          _pieceService.getPiecesByIdsStream(pieceIds);

      return Rx.combineLatest2(
        stylesByIdStream,
        piecesByIdStream,
        (Map<String, Style> styles, Map<String, Piece> pieces) => (
          filteredOutfits,
          styles,
          pieces,
        ),
      );
    });
  }

  Stream<List<Outfit>> _getFilteredOutfitsStream({
    Style? styleFilter,
    TemperatureType? temperatureFilter,
    WearHistory? historySort,
  }) {
    return getAllOutfitsStream().map((List<Outfit> outfits) {
      final List<Outfit> filteredOutfits = outfits.where((outfit) {
        final bool matchesStyle = styleFilter == null ||
            outfit.styleIds.any((id) => id == styleFilter.id);
        final bool matchesTemperature = temperatureFilter == null ||
            outfit.temperature == temperatureFilter;

        return matchesStyle && matchesTemperature;
      }).toList();

      if (historySort != null) {
        _sortOutfitsByHistory(filteredOutfits, historySort);
      }

      return filteredOutfits;
    });
  }

  void _sortOutfitsByHistory(List<Outfit> outfits, WearHistory historySort) {
    final comparisonFactor = historySort == WearHistory.mostRecently ? -1 : 1;

    outfits.sort((a, b) {
      if (a.lastWorn == null && b.lastWorn == null) return 0;
      if (a.lastWorn == null) return -comparisonFactor; // null at bottom/top
      if (b.lastWorn == null) return comparisonFactor; // null at top/bottom
      return comparisonFactor * a.lastWorn!.compareTo(b.lastWorn!);
    });
  }

  // returns one outfit by id and its (styleId -> style), (pieceId -> piece) dictionaries
  Stream<(Outfit?, Map<String, Style>, Map<String, Piece>)>
      getOutfitDetailByIdStream(String outfitId) {
    final Stream<Outfit?> outfitStream = getOutfitByIdStream(outfitId);

    return outfitStream.switchMap((Outfit? outfit) {
      if (outfit == null) {
        return Stream.value((null, <String, Style>{}, <String, Piece>{}));
      }

      final Set<String> styleIds = outfit.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getStylesByIdsStream(styleIds);

      final Set<String> pieceIds = outfit.pieceIds.toSet();
      final Stream<Map<String, Piece>> piecesStream =
          _pieceService.getPiecesByIdsStream(pieceIds);

      return Rx.combineLatest2<Map<String, Style>, Map<String, Piece>,
          (Outfit?, Map<String, Style>, Map<String, Piece>)>(
        stylesStream,
        piecesStream,
        (styles, pieces) => (outfit, styles, pieces),
      );
    });
  }
}
