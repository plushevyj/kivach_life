import 'package:doctor/models/configuration_models/configuration_of_app/configuration_of_app.dart';
import 'package:get/get.dart';

class ConfigurationOfAppController extends GetxController {
  final configuration = Rxn<ConfigurationOfApp>(null);
  final payloadRoute = RxnString(null);

  // @override
  // void onInit() {
  //   url.listen((url) {
  //     Get.until((route) => Get.currentRoute == '/home');
  //   });
  //   super.onInit();
  // }
}
