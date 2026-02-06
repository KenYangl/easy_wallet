import 'package:get/get.dart';
import '/routes/app_routes.dart';

class CreateWalletController extends GetxController {

  /// 导航到应用首页
  void navigateToApp() {
    Get.offAllNamed(AppRoutes.app);
  }

  /// 导航到备份钱包提示页面
  void navigateToBackupWalletTipsPage() {
    Get.toNamed(AppRoutes.backupWalletTips);
  }
}