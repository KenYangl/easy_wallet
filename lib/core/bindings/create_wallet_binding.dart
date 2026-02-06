import 'package:get/get.dart';

import '/presentation/pages/onboarding/controllers/create_wallet_controller.dart';

class CreateWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWalletController>(() => CreateWalletController());
  }
}