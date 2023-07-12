import 'package:get/get.dart';


class DigitalController extends GetxController {
  DigitalController();

  final RxString value = ''.obs;

  final enableDialButton = true.obs;
  final showSecondAction = true.obs;
  final currentFieldLength = 0.obs;

  static const maxLength = 4;

  @override
  void onInit() {
    value.addListener(GetStream(onListen: () {
      currentFieldLength(value.value.length);
      enableDialButton(value.value.length < maxLength);
      if (value.value.length == maxLength) {
        () {};
      }
      showSecondAction(value.value.isEmpty);
    }));
    super.onInit();
  }

  void enter(int number) {
    if (value.value.length <= maxLength) {
      value.value += number.toString();
    }
  }

  void delete() {
    if (value.value.isNotEmpty) {
      value.value = value.value.substring(0, value.value.length - 1);
    }
  }

  void clear() {
    value('');
  }
}
