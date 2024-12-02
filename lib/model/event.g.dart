// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      name: json['name'] as String,
      eventDatetime: const TimestampConverter()
          .fromJson(json['eventDatetime'] as Timestamp),
      place: json['place'] as String,
      outfitId: json['outfitId'] as String?,
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
      temperature:
          $enumDecodeNullable(_$TemperatureEnumMap, json['temperature']),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'createdAt': value,
      'eventDatetime':
          const TimestampConverter().toJson(instance.eventDatetime),
      'place': instance.place,
      'name': instance.name,
      if (instance.outfitId case final value?) 'outfitId': value,
      'styleIds': instance.styleIds,
      if (_$TemperatureEnumMap[instance.temperature] case final value?)
        'temperature': value,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$TemperatureEnumMap = {
  Temperature.cold: 'cold',
  Temperature.chilly: 'chilly',
  Temperature.warm: 'warm',
  Temperature.hot: 'hot',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
