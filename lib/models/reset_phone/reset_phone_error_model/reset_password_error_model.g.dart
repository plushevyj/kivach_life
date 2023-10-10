// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResetPasswordErrorModelImpl _$$ResetPasswordErrorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordErrorModelImpl(
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
      remainingTime: json['remainingTime'] as int?,
    );

Map<String, dynamic> _$$ResetPasswordErrorModelImplToJson(
        _$ResetPasswordErrorModelImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'remainingTime': instance.remainingTime,
    };
