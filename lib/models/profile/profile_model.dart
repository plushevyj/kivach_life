import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../avatar/avatar_model.dart';
import '../patient/patient_model.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String? email,
    required List<String> roles,
    required String username,
    required Patient patient,
    required bool notificationEnabled,
    required String? phone,
    required Avatar? avatar,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
}
