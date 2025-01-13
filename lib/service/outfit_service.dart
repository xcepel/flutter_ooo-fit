import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/service/entity_service.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:rxdart/rxdart.dart';

class OutfitService extends EntityService<Outfit> {
  static const String errorStoreMessage =
      "There was a problem with saving the outfit. Please try again.";

  final StyleService _styleService;
  final PieceService _pieceService;

  const OutfitService(
    super.repository,
    super.authService,
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
    String? newImagePath;
    if (imagePath != null) {
      newImagePath = await uploadImage(imagePath);

      if (newImagePath == null) {
        return errorStoreMessage;
      }
    }

    final piece = Outfit(
      id: '',
      userId: getCurrentUserId(),
      name: name,
      pieceIds: pieceIds,
      styleIds: styleIds,
      temperature: temperature,
      imagePath: newImagePath,
      lastWorn: null,
    );

    try {
      await repository.add(piece);
    } catch (e) {
      return errorStoreMessage;
    }
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
    String? newImagePath;
    if (imagePath != null) {
      newImagePath = await uploadImage(imagePath);

      if (newImagePath == null) {
        return errorStoreMessage;
      }
    }

    if (newImagePath != null && outfit.imagePath != null) {
      await deleteImage(outfit.imagePath!);
    }

    final newOutfit = outfit.copyWith(
      name: name,
      pieceIds: pieceIds,
      styleIds: styleIds,
      temperature: temperature,
      imagePath: newImagePath,
      lastWorn: outfit.lastWorn,
    );

    try {
      await repository.setOrAdd(outfit.id, newOutfit);
    } catch (e) {
      return errorStoreMessage;
    }
    return null;
  }

  @override
  Future<String?> delete(Outfit entity) async {
    String? error = await super.delete(entity);
    if (error != null) {
      return error;
    }

    if (entity.imagePath != null) {
      deleteImage(entity.imagePath!);
    }
    return null;
  }

  Stream<List<Outfit>> getFilteredOutfitsStream({
    Style? styleFilter,
    TemperatureType? temperatureFilter,
    WearHistory? historySort,
  }) {
    return getAllStream().map((List<Outfit> outfits) {
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

  Stream<(List<Outfit>, Map<String, Style>, Map<String, Piece>)>
      getPieceOutfitsWithStylesAndPiecesStream({
    required String pieceId,
  }) {
    final Stream<List<Outfit>> filteredOutfitsStream = getAllStream().map(
      (List<Outfit> outfits) =>
          outfits.where((outfit) => outfit.pieceIds.contains(pieceId)).toList(),
    );

    return _combineOutfitsWithStylesAndPieces(filteredOutfitsStream);
  }

  Stream<(List<Outfit>, Map<String, Style>, Map<String, Piece>)>
      getFilteredOutfitsWithStylesAndPiecesStream({
    Style? styleFilter,
    TemperatureType? temperatureFilter,
    WearHistory? historySort,
  }) {
    final Stream<List<Outfit>> filteredOutfitsStream = getFilteredOutfitsStream(
      styleFilter: styleFilter,
      temperatureFilter: temperatureFilter,
      historySort: historySort,
    );

    return _combineOutfitsWithStylesAndPieces(filteredOutfitsStream);
  }

  Stream<(List<Outfit>, Map<String, Style>, Map<String, Piece>)>
      _combineOutfitsWithStylesAndPieces(
    Stream<List<Outfit>> outfitsStream,
  ) {
    return outfitsStream.switchMap((List<Outfit> outfits) {
      final Set<String> styleIds =
          outfits.expand((outfit) => outfit.styleIds).toSet();
      final Set<String> pieceIds =
          outfits.expand((outfit) => outfit.pieceIds).toSet();

      final Stream<Map<String, Style>> stylesByIdStream =
          _styleService.getByIdsStream(styleIds);
      final Stream<Map<String, Piece>> piecesByIdStream =
          _pieceService.getPiecesByIdsStream(pieceIds);

      return Rx.combineLatest2(
        stylesByIdStream,
        piecesByIdStream,
        (Map<String, Style> styles, Map<String, Piece> pieces) => (
          outfits,
          styles,
          pieces,
        ),
      );
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
    final Stream<Outfit?> outfitStream = getByIdStream(outfitId);

    return outfitStream.switchMap((Outfit? outfit) {
      if (outfit == null) {
        return Stream.value((null, <String, Style>{}, <String, Piece>{}));
      }

      final Set<String> styleIds = outfit.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getByIdsStream(styleIds);

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
