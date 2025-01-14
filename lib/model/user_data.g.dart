// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      if (instance.name case final value?) 'name': value,
      if (instance.city case final value?) 'city': value,
    };
