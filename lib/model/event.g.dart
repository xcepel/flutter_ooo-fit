// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      eventDatetime: DateTime.parse(json['eventDatetime'] as String),
      outfitId: json['outfitId'] as String?,
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
      temperature: $enumDecode(_$TemperatureEnumMap, json['temperature']),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      'eventDatetime': instance.eventDatetime.toIso8601String(),
      'name': instance.name,
      if (instance.outfitId case final value?) 'outfitId': value,
      'styleIds': instance.styleIds,
      'temperature': _$TemperatureEnumMap[instance.temperature]!,
      'userId': instance.userId,
    };

const _$TemperatureEnumMap = {
  Temperature.cold: 'cold',
  Temperature.chilly: 'chilly',
  Temperature.warm: 'warm',
  Temperature.hot: 'hot',
};
