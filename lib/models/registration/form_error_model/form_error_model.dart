import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../plain_password_model/plain_password.dart';

part 'form_error_model.freezed.dart';
part 'form_error_model.g.dart';

@freezed
class FormErrorModel with _$FormErrorModel {
  const factory FormErrorModel({
    List<String>? username,
    List<String>? email,
    List<String>? phone,
    PlainPassword? plainPassword,
    List<String>? agreeTerms,
  }) = _FormErrorModel;

  factory FormErrorModel.fromJson(Map<String, Object?> json) =>
      _$RegistrationErrorModelFromJson(json);
}
