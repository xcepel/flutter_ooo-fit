// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Style _$StyleFromJson(Map<String, dynamic> json) => Style(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      'name': instance.name,
      'userId': instance.userId,
    };
