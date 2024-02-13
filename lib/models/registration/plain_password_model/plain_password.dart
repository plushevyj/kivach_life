import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'plain_password.freezed.dart';
part 'plain_password.g.dart';

@freezed
class PlainPassword with _$PlainPassword {
  const factory PlainPassword({
    List<String>? first,
    List<String>? second,
  }) = _RegistrationErrorModel;

  factory PlainPassword.fromJson(Map<String, Object?> json) =>
      _$PlainPasswordFromJson(json);
}
