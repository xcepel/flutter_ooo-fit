// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piece.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Piece _$PieceFromJson(Map<String, dynamic> json) => Piece(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      piecePlacement:
          $enumDecode(_$PiecePlacementEnumMap, json['piecePlacement']),
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
      archived: json['archived'] as bool,
      lastWorn: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastWorn'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$PieceToJson(Piece instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'createdAt': value,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'piecePlacement': _$PiecePlacementEnumMap[instance.piecePlacement]!,
      'styleIds': instance.styleIds,
      'archived': instance.archived,
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

const _$PiecePlacementEnumMap = {
  PiecePlacement.head: 'head',
  PiecePlacement.neck: 'neck',
  PiecePlacement.body: 'body',
  PiecePlacement.top: 'top',
  PiecePlacement.waist: 'waist',
  PiecePlacement.bottom: 'bottom',
  PiecePlacement.feet: 'feet',
  PiecePlacement.hands: 'hands',
  PiecePlacement.other: 'other',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
