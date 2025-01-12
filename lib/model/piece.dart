import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/entity.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'piece.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Piece extends Entity {
  @TimestampConverter()
  final DateTime? createdAt;

  final String name;

  final String imagePath;

  final PiecePlacement piecePlacement;

  final List<String> styleIds;

  @TimestampConverter()
  final DateTime? lastWorn;

  //TODO: https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties
  const Piece({
    required super.id,
    required super.userId,
    this.createdAt,
    required this.name,
    required this.imagePath,
    required this.piecePlacement,
    required this.styleIds,
    this.lastWorn, // TODO tohle se bude nejspis pri vytvoreni setovat na date vytvoreni?
  });

  factory Piece.fromJson(Map<String, dynamic> json) => _$PieceFromJson(json);

  Map<String, dynamic> toJson() => _$PieceToJson(this);

  Piece copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    String? name,
    String? imagePath,
    PiecePlacement? piecePlacement,
    List<String>? styleIds,
    bool? isFavourite,
    DateTime? lastWorn,
  }) {
    return Piece(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      piecePlacement: piecePlacement ?? this.piecePlacement,
      styleIds: styleIds ?? this.styleIds,
      lastWorn: lastWorn ?? this.lastWorn,
    );
  }
}
