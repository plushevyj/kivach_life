// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokenModel _$$_TokenModelFromJson(Map<String, dynamic> json) =>
    _$_TokenModel(
      token: json['token'] as String,
      refresh_token: json['refresh_token'] as String,
      age: json['age'] as int,
    );

Map<String, dynamic> _$$_TokenModelToJson(_$_TokenModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refresh_token,
      'age': instance.age,
    };
