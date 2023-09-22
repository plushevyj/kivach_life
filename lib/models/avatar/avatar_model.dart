import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'avatar_model.freezed.dart';
part 'avatar_model.g.dart';

@freezed
class Avatar with _$Avatar {
  const factory Avatar({
    required String? file,
  }) = _Avatar;

  factory Avatar.fromJson(Map<String, Object?> json) =>
      _$AvatarFromJson(json);
}
