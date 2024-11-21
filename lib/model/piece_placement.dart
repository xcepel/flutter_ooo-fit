import 'package:json_annotation/json_annotation.dart';

part 'piece_placement.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PiecePlacement {
  final String id;
  final String name;

  const PiecePlacement({required this.id, required this.name});

  factory PiecePlacement.fromJson(Map<String, dynamic> json) =>
      _$PiecePlacementFromJson(json);

  Map<String, dynamic> toJson() => _$PiecePlacementToJson(this);
}
