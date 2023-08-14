import 'package:get/get.dart';

import '/modules/local_authentication/repository/local_authentication_repository.dart';

class SettingsPageController extends GetxController {
  final isPageLoading = true.obs;

  late final RxBool enableLocalPassword;
  late final RxBool enableBiometric;
  late final RxBool canAuthByBiometric;

  final localAuthenticationRepository = const LocalAuthenticationRepository();

  @override
  void onInit() async {
    canAuthByBiometric =
        (await localAuthenticationRepository.canAuthenticateByBiometric()).obs;
    final localAuthSetting =
        await localAuthenticationRepository.checkLocalAuthenticationSettings();
    enableLocalPassword = localAuthSetting.$1.obs;
    enableBiometric = localAuthSetting.$2.obs;
    isPageLoading(false);
    super.onInit();
  }
}
