import 'package:get/get.dart';

import '../repository/first_opening_app_repository.dart';

class FirstOpeningAppController extends GetxController {
  final _firstOpeningOfAppRepository = const FirstOpeningOfAppRepository();

  @override
  void onInit() async {
    final isFirstOpening =
        await _firstOpeningOfAppRepository.checkFirstOpening();
    if (isFirstOpening) {
      await Get.toNamed('/greeting_onboarding');
      await _firstOpeningOfAppRepository.saveFirstOpeningSetting(false);
    }
    super.onInit();
  }
}
