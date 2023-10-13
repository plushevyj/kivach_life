// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      email: json['email'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      username: json['username'] as String,
      notificationEnabled: json['notificationEnabled'] as bool,
      phone: json['phone'] as String,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'roles': instance.roles,
      'username': instance.username,
      'notificationEnabled': instance.notificationEnabled,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
    };
