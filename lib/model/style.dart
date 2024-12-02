import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/service/util/timestamp_converter.dart';

part 'style.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Style {
  final String id;

  @TimestampConverter()
  final DateTime? createdAt;

  final String name;

  const Style({required this.id, this.createdAt, required this.name});

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  Map<String, dynamic> toJson() => _$StyleToJson(this);

  Style copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
  }) {
    return Style(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }
}
