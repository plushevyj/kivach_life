import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'intent_browsable_uris.freezed.dart';
part 'intent_browsable_uris.g.dart';

@freezed
class IntentBrowsableUris with _$IntentBrowsableUris {
  const factory IntentBrowsableUris({
    required String scheme,
    required String host,
  }) = _IntentBrowsableUris;

  factory IntentBrowsableUris.fromJson(Map<String, Object?> json) =>
      _$IntentBrowsableUrisFromJson(json);
}
