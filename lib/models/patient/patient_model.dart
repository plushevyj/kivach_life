import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

@freezed
class Patient with _$Patient {
  const factory Patient({
    required String firstname,
    required String lastname,
    required String middlename,
    required String birthdate,
    required String sex,
  }) = _Patient;

  factory Patient.fromJson(Map<String, Object?> json) =>
      _$PatientFromJson(json);
}
