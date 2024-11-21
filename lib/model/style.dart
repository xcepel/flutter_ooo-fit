import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Style {
  final String id;
  final DateTime? createdAt;
  final String name;
  final String userId;

  const Style(
      {required this.id,
      this.createdAt,
      required this.name,
      required this.userId});

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  Map<String, dynamic> toJson() => _$StyleToJson(this);
}
