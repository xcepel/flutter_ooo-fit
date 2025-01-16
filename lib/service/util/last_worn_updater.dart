import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/service/event_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/piece_service.dart';

class LastWornUpdater {
  final EventService _eventService = GetIt.instance.get<EventService>();
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  final DateTime today = DateTime.now();

  Future<void> updateLastWorn() async {
    try {
      final DateTime normalizedToday =
          DateTime(today.year, today.month, today.day);
      // get past events, sort them chronologically, group them with outfits
      final List<Event> pastEvents = await _getPastEvents(normalizedToday);
      pastEvents.sort((a, b) => a.eventDatetime.compareTo(b.eventDatetime));
      final Map<String, List<Event>> eventsByOutfit =
          _groupEventsByOutfit(pastEvents);
      // update lastWorn in outfits and their pieces
      await _updateLastWornOutfits(eventsByOutfit);
    } catch (e) {
      print('Error - updating last worn dates: $e');
    }
  }

  Future<List<Event>> _getPastEvents(DateTime normalizedToday) async {
    final List<Event> events = await _eventService.getAllStream().first;
    return events.where((Event event) {
      final DateTime eventDate = DateTime(
        event.eventDatetime.year,
        event.eventDatetime.month,
        event.eventDatetime.day,
      );
      return eventDate.isBefore(normalizedToday) && event.outfitId != null;
    }).toList();
  }

  Map<String, List<Event>> _groupEventsByOutfit(List<Event> pastEvents) {
    final Map<String, List<Event>> eventsByOutfit = {};
    for (final Event event in pastEvents) {
      final String outfitId = event.outfitId!;
      eventsByOutfit.putIfAbsent(outfitId, () => []).add(event);
    }
    return eventsByOutfit;
  }

  Future<void> _updateLastWornOutfits(
      Map<String, List<Event>> eventsByOutfit) async {
    for (final entry in eventsByOutfit.entries) {
      final String outfitId = entry.key;
      final List<Event> outfitEvents = entry.value;

      final DateTime lastWornDate = outfitEvents.last.eventDatetime;
      final Outfit? outfit = await _outfitService.getByIdStream(outfitId).first;
      if (outfit != null) {
        await _outfitService.updateLastWornOutfit(
          outfit: outfit,
          lastWorn: lastWornDate,
        );

        await _updateLastWornPieces(outfit.pieceIds, lastWornDate);
      }
    }
  }

  Future<void> _updateLastWornPieces(
      List<String> pieceIds, DateTime lastWornDate) async {
    for (final String pieceId in pieceIds) {
      final Piece? piece = await _pieceService.getByIdStream(pieceId).first;
      if (piece != null) {
        await _pieceService.updateLastWornPiece(
          piece: piece,
          lastWorn: lastWornDate,
        );
      }
    }
  }
}
