// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      email: json['email'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      username: json['username'] as String,
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
      notificationEnabled: json['notificationEnabled'] as bool,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'email': instance.email,
      'roles': instance.roles,
      'username': instance.username,
      'patient': instance.patient,
      'notificationEnabled': instance.notificationEnabled,
      'phone': instance.phone,
      'avatar': instance.avatar,
    };
