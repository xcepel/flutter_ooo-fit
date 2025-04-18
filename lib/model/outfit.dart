import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/entity.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/model/util/reference_wrapper.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'outfit.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Outfit extends Entity {
  @TimestampConverter()
  final DateTime? createdAt;

  final String name;

  final String? imagePath;

  final List<String> pieceIds;

  final List<String> styleIds;

  final TemperatureType temperature;

  final bool archived;

  @TimestampConverter()
  final DateTime? lastWorn;

  const Outfit({
    required super.id,
    required super.userId,
    this.createdAt,
    required this.name,
    this.imagePath,
    required this.pieceIds,
    required this.styleIds,
    required this.temperature,
    required this.archived,
    this.lastWorn,
  });

  factory Outfit.fromJson(Map<String, dynamic> json) => _$OutfitFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitToJson(this);

  Outfit copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    String? name,
    ReferenceWrapper<String?>? imagePath,
    List<String>? pieceIds,
    List<String>? styleIds,
    TemperatureType? temperature,
    bool? archived,
    DateTime? lastWorn,
  }) {
    return Outfit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      imagePath: imagePath != null ? imagePath.value : this.imagePath,
      pieceIds: pieceIds ?? this.pieceIds,
      styleIds: styleIds ?? this.styleIds,
      temperature: temperature ?? this.temperature,
      archived: archived ?? this.archived,
      lastWorn: lastWorn ?? this.lastWorn,
    );
  }
}
