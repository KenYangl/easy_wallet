import 'package:get/get.dart';

import '/presentation/pages/home/views/buy_page.dart';
import '/presentation/pages/home/views/receive_page.dart';
import '/presentation/pages/home/views/send_page.dart';
import '/presentation/pages/home/views/transaction_history_page.dart';
import '/presentation/pages/home/views/select_wallet_page.dart';
import '/presentation/pages/onboarding/views/backup_wallet_tips_page.dart';
import '/presentation/pages/onboarding/views/create_wallet_page.dart';
import '/presentation/pages/onboarding/views/import_wallet_page.dart';
import '/presentation/pages/home/views/home_page.dart';
import '/presentation/pages/swap/views/swap_page.dart';
import '/presentation/pages/defi/defi_page.dart';
import '/presentation/pages/discover/discover_page.dart';
import '/presentation/pages/settings/views/settings_page.dart';
import '/presentation/pages/app/app_page.dart';
import '/presentation/pages/onboarding/views/onboarding_page.dart';

// 主要路由配置
class AppRoutes {
  /// 顶级路由
  static const String onboarding = '/onboarding';
  static const String createWallet = '/create_wallet';
  static const String importWallet = '/import_wallet';
  static const String backupWalletTips = '/backup_wallet_tips';

  /// 应用内部路由（需在 AppPage 内部）
  static const String app = '/app';
  static const String home = '/home';
  static const String swap = '/swap';
  static const String defi = '/defi';
  static const String discover = '/discover';

  /// Home
  static const String selectWallet = '/select_wallet';
  static const String send = '/send';
  static const String receive = '/receive';
  static const String buy = '/buy';
  static const String transactionHistory = '/transaction_history';

  /// Settings
  static const String settings = '/settings';

  static final List<GetPage> getPages = [
    // Onboarding 流程
    GetPage(name: onboarding, page: () => const OnboardingPage()),
    GetPage(name: createWallet, page: () => const CreateWalletPage()),
    GetPage(name: importWallet, page: () => const ImportWalletPage()),
    GetPage(name: backupWalletTips, page: () => const BackupWalletTipsPage()),

    // App Shell 及其子页面
    GetPage(
      name: app,
      page: () => const AppPage(),
      children: [
        GetPage(name: home, page: () => const HomePage()),
        GetPage(name: swap, page: () => SwapPage()),
        GetPage(name: defi, page: () => const DefiPage()),
        GetPage(name: discover, page: () => const DiscoverPage()),
        GetPage(name: settings, page: () => const SettingsPage()),
        GetPage(name: selectWallet, page: () => const SelectWalletPage()),
        GetPage(name: send, page: () => const SendPage()),
        GetPage(name: receive, page: () => const ReceivePage()),
        GetPage(name: buy, page: () => const BuyPage()),
        GetPage(name: transactionHistory, page: () => const TransactionHistoryPage()),
      ],
    ),
  ];

  static String getFullRoute(String subRoute) {
    return '$app$subRoute';
  }
}