import 'package:get/get.dart';
import '/routes/app_routes.dart';

class ImportWalletController extends GetxController {

  /// 导航到应用首页
  void navigateToApp() {
    Get.offAllNamed(AppRoutes.app);
  }
}