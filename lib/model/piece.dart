import 'package:json_annotation/json_annotation.dart';

part 'piece.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Piece {
  final String id;
  final DateTime? createdAt;
  final String name;
  // nullable imagePath?
  final String? imagePath;
  final String piecePlacementId;
  final List<String> styleIds;

  const Piece({
    required this.id,
    this.createdAt,
    required this.name,
    this.imagePath,
    required this.piecePlacementId,
    required this.styleIds,
  });

  factory Piece.fromJson(Map<String, dynamic> json) => _$PieceFromJson(json);

  Map<String, dynamic> toJson() => _$PieceToJson(this);
}
