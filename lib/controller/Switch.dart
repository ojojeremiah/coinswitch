import 'package:get/get.dart';

class SwitchX extends GetxController {
  RxBool on = false.obs;
  RxBool active = false.obs;
  RxBool modes = false.obs;

  void face() {
    on.value = on.value ? false : true;
  }

  void location() {
    active.value = active.value ? false : true;
  }

  void mode() {
    modes.value = modes.value ? false : true;
  }
}