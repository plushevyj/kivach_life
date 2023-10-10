// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plain_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistrationErrorModelImpl _$$RegistrationErrorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistrationErrorModelImpl(
      first:
          (json['first'] as List<dynamic>?)?.map((e) => e as String).toList(),
      second:
          (json['second'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RegistrationErrorModelImplToJson(
        _$RegistrationErrorModelImpl instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
    };
