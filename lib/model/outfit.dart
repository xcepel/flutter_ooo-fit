import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'outfit.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Outfit {
  final String id;

  @TimestampConverter()
  final DateTime? createdAt;

  final String name;

  final String? imagePath;

  final List<String> pieceIds;

  final List<String> styleIds;

  final TemperatureType temperature;

  final bool isFavourite;

  @TimestampConverter()
  final DateTime? lastWorn;

  const Outfit(
      {required this.id,
      this.createdAt,
      required this.name,
      this.imagePath,
      required this.pieceIds,
      required this.styleIds,
      required this.temperature,
      required this.isFavourite,
      this.lastWorn});

  factory Outfit.fromJson(Map<String, dynamic> json) => _$OutfitFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitToJson(this);

  Outfit copyWith(
      {String? id,
      DateTime? createdAt,
      String? name,
      String? imagePath,
      List<String>? pieceIds,
      List<String>? styleIds,
      TemperatureType? temperature,
      bool? isFavourite,
      DateTime? lastWorn}) {
    return Outfit(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        pieceIds: pieceIds ?? this.pieceIds,
        styleIds: styleIds ?? this.styleIds,
        temperature: temperature ?? this.temperature,
        isFavourite: isFavourite ?? this.isFavourite,
        lastWorn: lastWorn ?? this.lastWorn);
  }
}
