import 'package:hive_flutter/hive_flutter.dart';

part 'local_password_model.g.dart';

@HiveType(typeId: 1)
class LocalPassword extends HiveObject {
  LocalPassword({required this.hash});

  @HiveField(0, defaultValue: null)
  String? hash;
}
