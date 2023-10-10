import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'reset_password_error_model.freezed.dart';
part 'reset_password_error_model.g.dart';

@freezed
class ResetPasswordErrorModel with _$ResetPasswordErrorModel {
  const factory ResetPasswordErrorModel({
    List<String>? phone,
    int? remainingTime,
  }) = _ResetPasswordErrorModel;

  factory ResetPasswordErrorModel.fromJson(Map<String, Object?> json) =>
      _$ResetPasswordErrorModelFromJson(json);
}
