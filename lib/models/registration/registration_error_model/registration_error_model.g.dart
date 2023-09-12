// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'registration_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RegistrationErrorModel _$$_RegistrationErrorModelFromJson(
        Map<String, dynamic> json) =>
    _$_RegistrationErrorModel(
      username: (json['username'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
      plainPassword: json['plainPassword'] == null
          ? null
          : PlainPassword.fromJson(
              json['plainPassword'] as Map<String, dynamic>),
      agreeTerms: (json['agreeTerms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_RegistrationErrorModelToJson(
        _$_RegistrationErrorModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'plainPassword': instance.plainPassword,
      'agreeTerms': instance.agreeTerms,
    };
