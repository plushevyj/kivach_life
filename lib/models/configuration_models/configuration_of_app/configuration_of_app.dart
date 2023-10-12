// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../intent_browsable_uris/intent_browsable_uris.dart';
import '../navbar_model/navbar_model.dart';

part 'configuration_of_app.freezed.dart';
part 'configuration_of_app.g.dart';

@freezed
class ConfigurationOfApp with _$ConfigurationOfApp {
  const factory ConfigurationOfApp({
    required String BASE_URL,
    required String ITUNES_URL_FOR_REQUEST,
    required List<String> ALLOWED_EXTERNAL_URLS,
    required List<IntentBrowsableUris> INTENT_BROWSABLE_URIS,
    required List<NavbarModel> NAVBAR,
  }) = _ConfigurationOfApp;

  factory ConfigurationOfApp.fromJson(Map<String, Object?> json) =>
      _$ConfigurationOfAppFromJson(json);
}
