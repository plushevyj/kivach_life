import 'package:doctor/modules/account/controllers/avatar_controller.dart';
import 'package:get/get.dart';

import '../../../modules/account/controllers/account_controller.dart';
import '../../../modules/authentication/repository/login_repository.dart';

class ProfileSettingsPageController extends GetxController {
  @override
  void onClose() async {
    final profile = await const LoginRepository().logInByToken();
    Get.put(AccountController(), permanent: true).profile(profile);
    Get.find<AvatarController>().onInit();
    super.onClose();
  }
}
