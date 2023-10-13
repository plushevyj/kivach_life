import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'navbar_menu.freezed.dart';
part 'navbar_menu.g.dart';

@freezed
class NavbarMenu with _$NavbarMenu {
  const factory NavbarMenu({
    required String icon,
    required String label,
    required String route,
  }) = _NavbarMenu;

  factory NavbarMenu.fromJson(Map<String, Object?> json) =>
      _$NavbarMenuFromJson(json);
}
