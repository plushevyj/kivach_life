import 'package:hive_flutter/hive_flutter.dart';

class FirstOpeningOfAppRepository {
  const FirstOpeningOfAppRepository();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox('firstOpeningApp');
  }

  Future<bool> checkFirstOpening() async {
    final box = await _openStorage();
    final isFirstOpening = (() {
      if (box.isEmpty) return true;
      final check = box.get('value') as bool;
      return check;
    }());
    // todo: toogle this lines
    // return isFirstOpening;
    return true;
  }

  Future<void> saveFirstOpeningSetting(bool value) async {
    final box = await _openStorage();
    await box.put('value', value);
  }
}
