// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outfit _$OutfitFromJson(Map<String, dynamic> json) => Outfit(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      pieceIds:
          (json['pieceIds'] as List<dynamic>).map((e) => e as String).toList(),
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
      temperature: $enumDecode(_$TemperatureEnumMap, json['temperature']),
    );

Map<String, dynamic> _$OutfitToJson(Outfit instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      'name': instance.name,
      if (instance.imagePath case final value?) 'imagePath': value,
      'pieceIds': instance.pieceIds,
      'styleIds': instance.styleIds,
      'temperature': _$TemperatureEnumMap[instance.temperature]!,
    };

const _$TemperatureEnumMap = {
  Temperature.cold: 'cold',
  Temperature.chilly: 'chilly',
  Temperature.warm: 'warm',
  Temperature.hot: 'hot',
};
