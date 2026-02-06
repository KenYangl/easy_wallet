import 'package:get/get.dart';

import '/presentation/pages/swap/controllers/swap_controller.dart';

class SwapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SwapController>(() => SwapController());
  }
}