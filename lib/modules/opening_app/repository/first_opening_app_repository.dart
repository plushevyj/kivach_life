import 'package:shared_preferences/shared_preferences.dart';

class _FirstOpeningKeyStore {
  _FirstOpeningKeyStore._();

  static const String isFirstOpened = 'isFirstOpened';
}

class FirstOpeningOfAppRepository {
  const FirstOpeningOfAppRepository();

  Future<bool> checkFirstOpening() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstOpening = prefs.getBool(_FirstOpeningKeyStore.isFirstOpened);
    return isFirstOpening ?? false;
  }

  Future<void> saveFirstOpeningSetting(bool isFirstOpened) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_FirstOpeningKeyStore.isFirstOpened, isFirstOpened);
  }
}
