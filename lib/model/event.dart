import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/entity.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Event extends Entity {
  @TimestampConverter()
  final DateTime? createdAt;

  @TimestampConverter()
  final DateTime eventDatetime;

  final String? place;

  final String? name;

  final String? outfitId;

  final List<String> styleIds;

  // temperature can be fetched later if event is too far in the future?
  final TemperatureType? temperature;

  const Event({
    required super.id,
    required super.userId,
    this.createdAt,
    required this.name,
    required this.eventDatetime,
    required this.place,
    required this.outfitId,
    required this.styleIds,
    required this.temperature,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  //TODO: https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties
  Event copyWith({
    String? id,
    String? userId,
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
      userId: userId ?? this.userId,
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
