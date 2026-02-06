import 'package:get/get.dart';

import '/presentation/pages/settings/controllers/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}