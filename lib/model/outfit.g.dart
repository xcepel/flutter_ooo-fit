// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outfit _$OutfitFromJson(Map<String, dynamic> json) => Outfit(
      id: json['id'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      pieceIds:
          (json['pieceIds'] as List<dynamic>).map((e) => e as String).toList(),
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
      temperature: $enumDecode(_$TemperatureEnumMap, json['temperature']),
      isFavourite: json['isFavourite'] as bool,
      lastWorn: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastWorn'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$OutfitToJson(Outfit instance) => <String, dynamic>{
      'id': instance.id,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'createdAt': value,
      'name': instance.name,
      if (instance.imagePath case final value?) 'imagePath': value,
      'pieceIds': instance.pieceIds,
      'styleIds': instance.styleIds,
      'temperature': _$TemperatureEnumMap[instance.temperature]!,
      'isFavourite': instance.isFavourite,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.lastWorn, const TimestampConverter().toJson)
          case final value?)
        'lastWorn': value,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$TemperatureEnumMap = {
  TemperatureType.cold: 'cold',
  TemperatureType.chilly: 'chilly',
  TemperatureType.warm: 'warm',
  TemperatureType.hot: 'hot',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
