import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/style_service.dart';

class EventService {
  final DatabaseService<Event> _eventRepository;
  final StyleService _styleService;
  final OutfitService _outfitService;

  const EventService(
    this._eventRepository,
    this._styleService,
    this._outfitService,
  );

  Future<String?> saveEvent({
    required String? name,
    required DateTime? eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) async {
    String? error = validate(
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );
    if (error != null) {
      return error;
    }

    final piece = Event(
      id: '',
      name: name!,
      eventDatetime: eventDatetime!,
      place: place!,
      outfitId: outfitId!,
      styleIds: styleIds!,
      temperature: temperature!,
    );

    await _eventRepository.add(piece);
    return null;
  }

  Future<String?> updateEvent({
    required Event event,
    required String? name,
    required DateTime? eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) async {
    String? error = validate(
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );
    if (error != null) {
      return error;
    }

    final newPiece = event.copyWith(
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );
    //TODO: implement and use update
    await _eventRepository.setOrAdd(event.id, newPiece);
    return null;
  }

  String? validate({
    required String? name,
    required DateTime? eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String>? styleIds,
    required TemperatureType? temperature,
  }) {
    if (name == null ||
        eventDatetime == null ||
        place == null ||
        (styleIds == null || styleIds.isEmpty)) {
      return 'All cells must contain a value';
    }
    return null;
  }

  //TODO: getters
}
