import 'package:get/get.dart';

// bindings
import '/core/bindings/app_bindings.dart';
import '/core/bindings/settings_binding.dart';
import '/core/bindings/create_wallet_binding.dart';
import '/core/bindings/swap_binding.dart';
import '/core/bindings/home_binding.dart';
import '/core/bindings/defi_binding.dart';
import '/core/bindings/discover_binding.dart';

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
  /// Onboarding 流程路由
  static const String onboarding = '/onboarding';
  static const String createWallet = '/create_wallet';
  static const String importWallet = '/import_wallet';
  static const String backupWalletTips = '/backup_wallet_tips';

  /// App Shell 及其子页面
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
    GetPage(name: createWallet, page: () => const CreateWalletPage(), binding: CreateWalletBinding()),
    GetPage(name: importWallet, page: () => const ImportWalletPage()),
    GetPage(name: backupWalletTips, page: () => const BackupWalletTipsPage()),

    // App 
    GetPage(name: app, page: () => const AppPage(), binding: AppBindings()),
    // Navigation bottom bar Routes
    GetPage(name: home, page: () => const HomePage(), binding: HomeBinding()),
    GetPage(name: swap, page: () => const SwapPage(), binding: SwapBinding()),
    GetPage(name: defi, page: () => const DefiPage(), binding: DefiBinding()),
    GetPage(name: discover, page: () => const DiscoverPage(), binding: DiscoverBinding()),
    // Home sub routes
    GetPage(name: settings, page: () => const SettingsPage(), binding: SettingsBinding()),
    GetPage(name: selectWallet, page: () => const SelectWalletPage()),
    GetPage(name: send, page: () => const SendPage()),
    GetPage(name: receive, page: () => const ReceivePage()),
    GetPage(name: buy, page: () => const BuyPage()),
    GetPage(name: transactionHistory, page: () => const TransactionHistoryPage()),
  ];
}