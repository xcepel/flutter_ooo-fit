// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piece.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Piece _$PieceFromJson(Map<String, dynamic> json) => Piece(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      piecePlacementId: json['piecePlacementId'] as String,
      styleIds:
          (json['styleIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PieceToJson(Piece instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      'name': instance.name,
      if (instance.imagePath case final value?) 'imagePath': value,
      'piecePlacementId': instance.piecePlacementId,
      'styleIds': instance.styleIds,
    };
