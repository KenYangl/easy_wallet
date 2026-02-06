import 'package:get/get.dart';

import '/presentation/pages/home/controllers/home_controller.dart';
import '/presentation/pages/swap/controllers/swap_controller.dart';
import '/presentation/pages/defi/defi_controller.dart';
import '/presentation/pages/discover/discover_controller.dart';
import '/presentation/pages/settings/controllers/settings_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.put(SwapController(), permanent: true);
    Get.put(DefiController(), permanent: true);
    Get.put(DiscoverController(), permanent: true);

    Get.put(SettingsController());
  }
}