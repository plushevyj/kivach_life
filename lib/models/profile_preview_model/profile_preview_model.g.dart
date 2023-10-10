// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfilePreviewImpl _$$ProfilePreviewImplFromJson(Map<String, dynamic> json) =>
    _$ProfilePreviewImpl(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      middlename: json['middlename'] as String?,
      birthdate: json['birthdate'] as String,
      sex: json['sex'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfilePreviewImplToJson(
        _$ProfilePreviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'middlename': instance.middlename,
      'birthdate': instance.birthdate,
      'sex': instance.sex,
      'user': instance.user,
    };
