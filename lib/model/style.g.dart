// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Style _$StyleFromJson(Map<String, dynamic> json) => Style(
      id: json['id'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      name: json['name'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
      'id': instance.id,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'createdAt': value,
      'name': instance.name,
      'color': instance.color,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
