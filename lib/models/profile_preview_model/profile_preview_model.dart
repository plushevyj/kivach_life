import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '/models/user/user_model.dart';

part 'profile_preview_model.freezed.dart';
part 'profile_preview_model.g.dart';

@freezed
class ProfilePreview with _$ProfilePreview {
  const factory ProfilePreview({
    required int id,
    required String firstname,
    required String lastname,
    required String? middlename,
    required String birthdate,
    required String sex,
    required User? user,
  }) = _ProfilePreview;

  factory ProfilePreview.fromJson(Map<String, Object?> json) =>
      _$ProfilePreviewFromJson(json);
}
