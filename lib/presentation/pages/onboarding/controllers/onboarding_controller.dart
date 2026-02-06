import 'package:get/get.dart';
import '/routes/app_routes.dart';

class OnboardingController extends GetxController {
  // 跳转到创建钱包页
  void navigateToCreateWallet() {
    Get.toNamed(AppRoutes.createWallet);
  }

  // 跳转到导入钱包页
  void navigateToImportWallet() {
    Get.toNamed(AppRoutes.importWallet);
  }
}