import 'package:hive_flutter/hive_flutter.dart';

import '../models/local_authentication_settings_model/local_authentication_settings_model.dart';
import 'local_authentication_repository.dart';

class LocalAuthenticationRepositoryImpl
    implements LocalAuthenticationRepository {
  const LocalAuthenticationRepositoryImpl();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox<LocalAuthenticationSettings>(
        'localAuthenticationSettings');
  }

  Future<void> _closeStorage() async {
    await Hive.box('localAuthenticationSettings').close();
  }

  @override
  Future<LocalAuthenticationSettings> checkSettings() async {
    final storage = await _openStorage();
    print(storage.length);
    if (storage.length > 1) {
      throw Exception('HiveBox \'localAuthenticationSettings\' must have a length that is 1.');
    }

    return storage.getAt(0);
  }

  @override
  Future<LocalAuthenticationSettings> getSettings() async {
    final storage = await _openStorage();
    return storage.getAt(0);
  }
}
