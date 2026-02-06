import 'package:get/get.dart';
import 'package:easy_wallet/data/remote/wallet_api.dart';

import '../views/message_page.dart';
import '../views/scan_qr_code_page.dart';
import '/routes/app_routes.dart';

class HomeController extends GetxController {
  final WalletApi _walletApi = WalletApi();

  final RxBool isLoading = false.obs;

  /// 导航到选择钱包页面
  void navigateToSelectWalletPage() {
    Get.toNamed(AppRoutes.selectWallet);
  }

  /// 导航到复制地址页面
  void navigateToAddressPage() {
    Get.toNamed('/defi');
  }
  
  /// 导航到消息页面
  void navigateToMessagePage() {
    Get.to(() => const MessagePage());
  }
  
  /// 导航到扫描二维码页面
  void navigateToScanQRCodePage() {
    Get.to(() => const ScanQRCodePage(), transition: Transition.downToUp);
  }
  
  /// 导航到设置页面
  void navigateToSettingsPage() {
    Get.toNamed(AppRoutes.getFullRoute(AppRoutes.settings));
  }

  /// 导航到转账页面
  void navigateToSendPage() {
    Get.toNamed(AppRoutes.send);
  }

  /// 导航到收款页面
  void navigateToReceivePage() {
    Get.toNamed(AppRoutes.receive);
  }

  /// 导航到购买页面
  void navigateToBuyPage() {
    Get.toNamed(AppRoutes.buy);
  }

  /// 导航到交易历史页面
  void navigateToTransactionHistoryPage() {
    Get.toNamed(AppRoutes.transactionHistory);
  }

  /// 加载钱包余额
  // Future<void> loadWalletBalances() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await _walletApi.getWalletBalances(
  //       address: '0x...',
  //       chain: 'ethereum',
  //     );
      
  //     if (response.success) {

  //     } else {
  //       Get.snackbar('Error', response.message);
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}