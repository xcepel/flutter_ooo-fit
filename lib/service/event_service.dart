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
      this._eventRepository, this._styleService, this._outfitService);

  Future<String?> saveEvent(
      {required String? name,
      required DateTime? eventDatetime,
      required String? place,
      required String? outfitId,
      required List<String>? styleIds,
      required TemperatureType? temperature}) async {
    if (name == null ||
        eventDatetime == null ||
        place == null ||
        (styleIds == null || styleIds.isEmpty)) {
      return 'All cells must contain a value';
    }

    final piece = Event(
      id: '',
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );

    await _eventRepository.add(piece);
    return null;
  }
}
