import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'navbar_model.freezed.dart';
part 'navbar_model.g.dart';

@freezed
class NavbarModel with _$NavbarModel {
  const factory NavbarModel({
    required String icon,
    required String label,
    required String route,
  }) = _NavbarModel;

  factory NavbarModel.fromJson(Map<String, Object?> json) =>
      _$NavbarModelFromJson(json);
}
