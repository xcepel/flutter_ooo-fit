import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Event {
  final String id;

  @TimestampConverter()
  final DateTime? createdAt;

  @TimestampConverter()
  final DateTime eventDatetime;

  final String place;

  final String name;

  // outfit can be added later, after event creation?
  final String? outfitId;

  final List<String> styleIds;

  // temperature can be fetched later if event is too far in the future?
  final TemperatureType? temperature;

  const Event(
      {required this.id,
      this.createdAt,
      required this.name,
      required this.eventDatetime,
      required this.place,
      required this.outfitId,
      required this.styleIds,
      required this.temperature});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? eventDatetime,
    String? place,
    String? name,
    String? outfitId,
    List<String>? styleIds,
    TemperatureType? temperature,
  }) {
    return Event(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      eventDatetime: eventDatetime ?? this.eventDatetime,
      place: place ?? this.place,
      name: name ?? this.name,
      outfitId: outfitId ?? this.outfitId,
      styleIds: styleIds ?? this.styleIds,
      temperature: temperature ?? this.temperature,
    );
  }
}
