import 'package:get/get.dart';
import '/core/services/native_service.dart';
import '/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final NativeService _nativeService = Get.find<NativeService>();

  // 跳转到创建钱包页
  void navigateToCreateWallet() async {
    await _nativeService.createWallet();
    Get.toNamed(AppRoutes.createWallet);
  }

  // 跳转到导入钱包页
  void navigateToImportWallet() async {
    await _nativeService.restoreWallet('ff ggg rrr hhh fff ddd ccc ddd ');
    Get.toNamed(AppRoutes.importWallet);
  }
}