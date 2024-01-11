import 'package:get/get.dart';

import '../../../models/configuration_models/configuration_of_app/configuration_of_app.dart';

class ConfigurationOfAppController extends GetxController {
  final configuration = Rxn<ConfigurationOfApp>(null);
  final payloadRoute = RxnString(null);
}
