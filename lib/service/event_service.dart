import 'package:ooo_fit/model/event.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/model/user_data.dart';
import 'package:ooo_fit/model/util/reference_wrapper.dart';
import 'package:ooo_fit/service/entity_service.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/service/user_data_service.dart';
import 'package:ooo_fit/service/util/date_normalize.dart';
import 'package:ooo_fit/service/weather_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/weather.dart';

class EventService extends EntityService<Event> {
  static const String errorStoreMessage =
      "There was a problem with saving the event. Please try again.";

  final StyleService _styleService;
  final OutfitService _outfitService;
  final WeatherService _weatherService;
  final UserDataService _userDataService;

  const EventService(
    super.repository,
    super.authService,
    this._styleService,
    this._outfitService,
    this._weatherService,
    this._userDataService,
  );

  Future<String?> saveEvent({
    required String? name,
    required DateTime eventDatetime,
    required String? place,
    required String? outfitId,
    required List<String> styleIds,
    required TemperatureType? temperature,
  }) async {
    final event = Event(
      id: '',
      userId: getCurrentUserId(),
      name: name,
      eventDatetime: eventDatetime,
      place: place,
      outfitId: outfitId,
      styleIds: styleIds,
      temperature: temperature,
    );

    try {
      await repository.add(event);
    } catch (e) {
      return errorStoreMessage;
    }
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
    final Event newEvent = event.copyWith(
      name: ReferenceWrapper.value(name),
      eventDatetime: eventDatetime,
      place: ReferenceWrapper.value(place),
      outfitId: ReferenceWrapper.value(outfitId),
      styleIds: styleIds,
      temperature: temperature,
    );

    try {
      await repository.setOrAdd(event.id, newEvent);
    } catch (e) {
      return errorStoreMessage;
    }
    return null;
  }

  Future<String?> wearOutfitNow({required String outfitId}) async {
    UserData? currentUserData = await _userDataService.getCurrentUsersData();
    String? cityName = currentUserData?.city;

    TemperatureType? currentTemp;
    if (cityName != null) {
      Weather weather = await _weatherService.getWeatherByCityName(cityName);
      currentTemp = _weatherService.getTemperatureTypeFromWeather(weather);
    }

    return saveEvent(
      name: null,
      eventDatetime: DateTime.now(),
      place: null,
      outfitId: outfitId,
      styleIds: [],
      temperature: currentTemp,
    );
  }

  Stream<Map<DateTime, List<Event>>> getGroupedEventsStream() {
    return getAllStream().map((List<Event> events) {
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

    return getAllStream().map((List<Event> events) {
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
    final Stream<Event?> eventStream = getByIdStream(eventId);

    return eventStream.switchMap((Event? event) {
      if (event == null) {
        return Stream.value((null, null, <String, Style>{}));
      }

      final Stream<Outfit?> outfitStream = event.outfitId != null
          ? _outfitService.getByIdStream(event.outfitId!)
          : Stream.value(null);

      final Set<String> styleIds = event.styleIds.toSet();
      final Stream<Map<String, Style>> stylesStream =
          _styleService.getByIdsStream(styleIds);

      return Rx.combineLatest2<Outfit?, Map<String, Style>,
          (Event?, Outfit?, Map<String, Style>)>(
        outfitStream,
        stylesStream,
        (outfit, styles) => (event, outfit, styles),
      );
    });
  }
}
