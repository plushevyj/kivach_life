// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_of_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigurationOfAppImpl _$$ConfigurationOfAppImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfigurationOfAppImpl(
      BASE_URL: json['BASE_URL'] as String,
      ITUNES_URL_FOR_REQUEST: json['ITUNES_URL_FOR_REQUEST'] as String,
      ALLOWED_EXTERNAL_URLS: (json['ALLOWED_EXTERNAL_URLS'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      INTENT_BROWSABLE_URIS: (json['INTENT_BROWSABLE_URIS'] as List<dynamic>)
          .map((e) => IntentBrowsableUris.fromJson(e as Map<String, dynamic>))
          .toList(),
      NAVBAR: (json['NAVBAR'] as List<dynamic>)
          .map((e) => NavbarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConfigurationOfAppImplToJson(
        _$ConfigurationOfAppImpl instance) =>
    <String, dynamic>{
      'BASE_URL': instance.BASE_URL,
      'ITUNES_URL_FOR_REQUEST': instance.ITUNES_URL_FOR_REQUEST,
      'ALLOWED_EXTERNAL_URLS': instance.ALLOWED_EXTERNAL_URLS,
      'INTENT_BROWSABLE_URIS': instance.INTENT_BROWSABLE_URIS,
      'NAVBAR': instance.NAVBAR,
    };
