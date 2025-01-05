import 'dart:async';

import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:rxdart/rxdart.dart';

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

    final event = Event(
      id: '',
      name: name!,
      eventDatetime: eventDatetime!,
      place: place!,
      outfitId: outfitId!,
      styleIds: styleIds!,
      temperature: temperature!,
    );

    await _eventRepository.add(event);
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

    final newEvent = event.copyWith(
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );
    //TODO: implement and use update
    await _eventRepository.setOrAdd(event.id, newEvent);
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

  Stream<List<Event>> getAllEventsStream() {
    return _eventRepository.observeDocuments();
  }

  Stream<Event?> getEventByIdStream(String eventId) {
    return _eventRepository.observeDocument(eventId);
  }

  // TODO sort by time
  Stream<Map<DateTime, List<Event>>> getGroupedEventsStream() {
    return _eventRepository.observeDocuments().map((List<Event> events) {
      final Map<DateTime, List<Event>> groupedEvents = {};

      // group by date
      for (final Event event in events) {
        final DateTime date = DateTime(event.eventDatetime.year,
            event.eventDatetime.month, event.eventDatetime.day);

        groupedEvents.containsKey(date)
            ? groupedEvents[date]!.add(event)
            : groupedEvents[date] = [event];
      }
      return groupedEvents;
    });
  }

  Stream<(Event?, Outfit?, Map<String, Style>)> getEventDetailByIdStream(
      String eventId) {
    final Stream<Event?> eventStream = getEventByIdStream(eventId);

    return eventStream.switchMap((Event? event) {
      if (event == null) {
        return Stream.value((null, null, <String, Style>{}));
      }

      final Stream<Outfit?> outfitStream = event.outfitId != null
          ? _outfitService.getOutfitByIdStream(event.outfitId!)
          : Stream.value(null);

      final Set<String> styleIds = event.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getStylesByIdsStream(styleIds);

      return Rx.combineLatest2<Outfit?, Map<String, Style>,
          (Event?, Outfit?, Map<String, Style>)>(
        outfitStream,
        stylesStream,
        (outfit, styles) => (event, outfit, styles),
      );
    });
  }
}
