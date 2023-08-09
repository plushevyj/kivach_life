import 'package:get/get.dart';

import '/modules/local_authentication/repository/local_authentication_repository.dart';

class SettingsPageController extends GetxController {
  final isPageLoading = true.obs;

  late final RxBool enableLocalPassword;
  late final RxBool enableBiometric;

  @override
  void onInit() async {
    final localAuthSetting = await const LocalAuthenticationRepository()
        .checkLocalAuthenticationSettings();
    enableLocalPassword = localAuthSetting.$1.obs;
    enableBiometric = localAuthSetting.$2.obs;
    isPageLoading(false);
    super.onInit();
  }
}
