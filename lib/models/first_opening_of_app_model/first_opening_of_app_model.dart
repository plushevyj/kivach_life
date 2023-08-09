import 'package:hive_flutter/hive_flutter.dart';

part 'first_opening_of_app_model.g.dart';

@HiveType(typeId: 2)
class FirstOpeningOfAppModel extends HiveObject {
  FirstOpeningOfAppModel({required this.state});

  @HiveField(0, defaultValue: false)
  bool state;
}
