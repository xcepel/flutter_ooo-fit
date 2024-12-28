import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  final String id;

  final String name;

  final String? profilePhotoPath;

  const User({
    required this.id,
    required this.name,
    this.profilePhotoPath,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? profilePhotoPath,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
    );
  }
}
