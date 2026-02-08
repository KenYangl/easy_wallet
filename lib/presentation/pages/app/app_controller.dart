import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/routes/app_routes.dart';
import '/core/constants/storage_keys.dart';
import '/core/constants/app_colors.dart';
import '../home/views/home_page.dart';
import '../swap/views/swap_page.dart';
import '/presentation/pages/defi/defi_page.dart';
import '/presentation/pages/discover/discover_page.dart';
import '/presentation/pages/home/controllers/home_controller.dart';
import '/presentation/pages/swap/controllers/swap_controller.dart';
import '/presentation/pages/defi/defi_controller.dart';
import '/presentation/pages/discover/discover_controller.dart';

class AppController extends GetxController {
  // 钱包状态（响应式）
  final RxBool hasWallet = false.obs;
  // 主题状态（响应式）
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  // 当前主题对应的颜色方案（响应式）
  final Rx<AppColorScheme> currentColors = Rx<AppColorScheme>(AppColors.light);

  final RxInt _selectedIndex = 0.obs;
  
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  final List<Widget> pages = [
    const HomePage(),
    const SwapPage(),
    const DefiPage(),
    const DiscoverPage(),
  ];

  final List<Map<String, dynamic>> navigationBars = [
    {
      'icon': const Icon(Icons.home_outlined),
      'selectedIcon': const Icon(Icons.home),
      'label': "home".tr,
    },
    {
      'icon': const Icon(Icons.whatshot_outlined),
      'selectedIcon': const Icon(Icons.whatshot_rounded),
      'label': "swap".tr,
    },
    {
      'icon': const Icon(Icons.person_outline),
      'selectedIcon': const Icon(Icons.person),
      'label': "defi".tr,
    },
    {
      'icon': const Icon(Icons.explore_outlined),
      'selectedIcon': const Icon(Icons.explore),
      'label': "discover".tr,
    }
  ];

  @override
  void onInit() {
    super.onInit();
    // 初始化时检查钱包状态
    // _checkWalletStatus();
    // _loadThemeSetting();
    // 监听主题模式变化，同步更新颜色方案
    // ever(themeMode, (ThemeMode mode) {
    //   _updateColorScheme(mode);
    // });
  }

  // 检查本地是否有钱包
  Future<void> _checkWalletStatus() async {
    final prefs = await SharedPreferences.getInstance();
    hasWallet.value = prefs.getBool(StorageKeys.hasWallet) ?? false;
  }

  // 加载本地保存的主题设置
  Future<void> _loadThemeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(StorageKeys.themeMode) ?? 2; // 默认跟随系统
    themeMode.value = ThemeMode.values[themeIndex];
    // 初始化颜色方案
    _updateColorScheme(themeMode.value);
    // 更新APP主题
    Get.changeThemeMode(themeMode.value);
  }

  // 根据主题模式更新颜色方案
  void _updateColorScheme(ThemeMode mode) {
    Brightness brightness;
    // 处理 "跟随系统" 模式
    if (mode == ThemeMode.system) {
      brightness = WidgetsBinding.instance.window.platformBrightness;
    } else {
      brightness = mode == ThemeMode.light ? Brightness.light : Brightness.dark;
    }
    // 更新响应式颜色方案
    currentColors.value = brightness == Brightness.light ? AppColors.light : AppColors.dark;
  }

  // 更新钱包状态（创建/导入后调用）
  Future<void> updateWalletStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.hasWallet, status);
    hasWallet.value = status;
    // 更新后刷新UI
    update();
  }

  // 更新主题设置并持久化
  Future<void> updateThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StorageKeys.themeMode, mode.index);
    themeMode.value = mode;
    // 实时切换APP主题
    Get.changeThemeMode(mode);
  }

  // 退出钱包（清空状态）
  Future<void> logoutWallet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.hasWallet);
    hasWallet.value = false;
  }
}