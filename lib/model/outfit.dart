import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/temperature.dart';

part 'outfit.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Outfit {
  final String id;
  final DateTime? createdAt;
  final String name;
  final String? imagePath;
  final List<String> pieceIds;
  final List<String> styleIds;
  final Temperature temperature;

  // create_datetime?

  const Outfit(
      {required this.id,
      this.createdAt,
      required this.name,
      this.imagePath,
      required this.pieceIds,
      required this.styleIds,
      required this.temperature});

  factory Outfit.fromJson(Map<String, dynamic> json) => _$OutfitFromJson(json);

  Map<String, dynamic> toJson() => _$OutfitToJson(this);
}
