// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navbar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NavbarModelImpl _$$NavbarModelImplFromJson(Map<String, dynamic> json) =>
    _$NavbarModelImpl(
      role: json['role'] as String,
      menu: (json['menu'] as List<dynamic>)
          .map((e) => NavbarMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NavbarModelImplToJson(_$NavbarModelImpl instance) =>
    <String, dynamic>{
      'role': instance.role,
      'menu': instance.menu,
    };
