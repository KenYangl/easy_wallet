import 'package:get/get.dart';

import '/presentation/pages/onboarding/views/backup_wallet_tips_page.dart';
import '/presentation/pages/onboarding/views/create_wallet_page.dart';
import '/presentation/pages/onboarding/views/import_wallet_page.dart';
import '/presentation/pages/home/home_page.dart';
import '/presentation/pages/swap/swap_page.dart';
import '/presentation/pages/defi/defi_page.dart';
import '/presentation/pages/discover/discover_page.dart';
import '/presentation/pages/settings/views/settings_page.dart';
import '/presentation/pages/app/app_page.dart';
import '/presentation/pages/onboarding/views/onboarding_page.dart';

// 主要路由配置
class AppRoutes {
  static final List<GetPage> getPages = [
    // Onboarding
    GetPage(name: onboarding, page: () => const OnboardingPage()),
    GetPage(name: createWallet, page: () => const CreateWalletPage()),
    GetPage(name: importWallet, page: () => const ImportWalletPage()),
    GetPage(name: backupWalletTips, page: () => const BackupWalletTipsPage()),

    // App
    GetPage(name: app, page: () => const AppPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: swap, page: () => const SwapPage()),
    GetPage(name: defi, page: () => const DefiPage()),
    GetPage(name: discover, page: () => const DiscoverPage()),
    GetPage(name: settings, page: () => const SettingsPage()),
  ];

  /// Onboarding
  static const String onboarding = '/onboarding';
  static const String createWallet = '/create_wallet';
  static const String importWallet = '/import_wallet';
  static const String backupWalletTips = '/backup_wallet_tips';
  static const String backupWalletTipsPage = '/backup_wallet_tips_page';


  /// App
  static const String app = '/app';

  /// Bottom navigation bar routes
  static const String home = '/home';
  static const String swap = '/swap';
  static const String defi = '/defi';
  static const String discover = '/discover';

  /// Settings
  static const String settings = '/settings';
}