import 'package:json_annotation/json_annotation.dart';
import 'package:ooo_fit/model/entity.dart';

part 'user_data.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserData extends Entity {
  final String? name;

  final String? city;

  const UserData({
    required super.id,
    required super.userId,
    required this.name,
    this.city,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserData copyWith({
    String? id,
    String? userId,
    String? name,
    String? city,
  }) {
    return UserData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      city: city ?? this.city,
    );
  }
}
