import 'package:hive_flutter/hive_flutter.dart';

import '/models/first_opening_of_app_model/first_opening_of_app_model.dart';

class FirstOpeningOfAppRepository {
  const FirstOpeningOfAppRepository();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox<FirstOpeningOfAppModel>('firstOpeningOfApp');
  }

  Future<bool> checkFirstOpening() async {
    final box = await _openStorage();
    final isFirstOpening = (() {
      if (box.isNotEmpty) {
        final check = box.getAt(0) as FirstOpeningOfAppModel;
        return check.state;
      } else {
        return true;
      }
    }());
    return isFirstOpening;
  }

  Future<void> saveFirstOpeningSetting(
      FirstOpeningOfAppModel firstOpening) async {
    final box = await _openStorage();
    if (box.isEmpty) {
      await box.add(firstOpening);
    } else {
      await box.putAt(0, firstOpening);
    }
  }
}