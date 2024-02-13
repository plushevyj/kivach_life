import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../plain_password_model/plain_password.dart';

part 'registration_error_model.freezed.dart';
part 'registration_error_model.g.dart';

@freezed
class RegistrationErrorModel with _$RegistrationErrorModel {
  const factory RegistrationErrorModel({
    List<String>? username,
    List<String>? email,
    List<String>? phone,
    PlainPassword? plainPassword,
    List<String>? agreeTerms,
  }) = _RegistrationErrorModel;

  factory RegistrationErrorModel.fromJson(Map<String, Object?> json) =>
      _$RegistrationErrorModelFromJson(json);
}
