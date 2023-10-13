import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../navbar_menu/navbar_menu.dart';

part 'navbar_model.freezed.dart';
part 'navbar_model.g.dart';

@freezed
class NavbarModel with _$NavbarModel {
  const factory NavbarModel({
    required String role,
    required List<NavbarMenu> menu,
  }) = _NavbarModel;

  factory NavbarModel.fromJson(Map<String, Object?> json) =>
      _$NavbarModelFromJson(json);
}
