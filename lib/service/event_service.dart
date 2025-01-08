import 'dart:async';

import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/database_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/util/date_normalize.dart';
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
    required DateTime eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String> styleIds,
    required TemperatureType temperature,
  }) async {
    final event = Event(
      id: '',
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );

    await _eventRepository.add(event);
    return null;
  }

  Future<String?> updateEvent({
    required Event event,
    required String? name,
    required DateTime eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String> styleIds,
    required TemperatureType? temperature,
  }) async {
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

  Future<String?> deleteEvent({required Event event}) async {
    await _eventRepository.delete(event.id);
    return null;
  }

  Stream<List<Event>> getAllEventsStream() {
    return _eventRepository.observeDocuments();
  }

  Stream<Event?> getEventByIdStream(String eventId) {
    return _eventRepository.observeDocument(eventId);
  }

  Stream<Map<DateTime, List<Event>>> getGroupedEventsStream() {
    return getAllEventsStream().map((List<Event> events) {
      final Map<DateTime, List<Event>> groupedEvents = {};
      for (final Event event in events) {
        final DateTime date = DateTime(
          event.eventDatetime.year,
          event.eventDatetime.month,
          event.eventDatetime.day,
        );

        groupedEvents.putIfAbsent(date, () => []).add(event);
      }

      groupedEvents.forEach((DateTime date, List<Event> eventList) {
        eventList.sort((a, b) => a.eventDatetime.compareTo(b.eventDatetime));
      });

      return groupedEvents;
    });
  }

  Stream<List<Event>> getEventsByDay(DateTime day) {
    final DateTime normalizedDay = DateNormalize(day).normalize();

    return getAllEventsStream().map((List<Event> events) {
      return events.where((Event event) {
        final DateTime eventDay = DateTime(
          event.eventDatetime.year,
          event.eventDatetime.month,
          event.eventDatetime.day,
        );
        return eventDay == normalizedDay;
      }).toList();
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
