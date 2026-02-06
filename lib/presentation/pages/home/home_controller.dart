import 'package:get/get.dart';
import 'package:easy_wallet/data/remote/wallet_api.dart';

class HomeController extends GetxController {
  final WalletApi _walletApi = WalletApi();

  final RxBool isLoading = false.obs;

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