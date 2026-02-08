import 'package:get/get.dart';
import '/core/services/native_service.dart';
import '/routes/app_routes.dart';

class CreateWalletController extends GetxController {

  @override
  onInit() {
    super.onInit();
    NativeService().createWallet();
  }

  /// 导航到应用首页
  void navigateToApp() {
    Get.offAllNamed(AppRoutes.app);
  }

  /// 导航到备份钱包提示页面
  void navigateToBackupWalletTipsPage() {
    Get.toNamed(AppRoutes.backupWalletTips);
  }
}