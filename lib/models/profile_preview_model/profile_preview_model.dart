import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'profile_preview_model.freezed.dart';
part 'profile_preview_model.g.dart';

@freezed
class ProfilePreview with _$ProfilePreview {
  const factory ProfilePreview({
    required int id,
    required String fullname,
  }) = _ProfilePreview;

  factory ProfilePreview.fromJson(Map<String, Object?> json) =>
      _$ProfilePreviewFromJson(json);
}
