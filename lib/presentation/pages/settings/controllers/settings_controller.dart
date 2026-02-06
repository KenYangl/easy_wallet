import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/about_us_page.dart';
import '../views/address_book_page.dart';
import '../views/currency_select_page.dart';
import '../views/language_select_page.dart';
import '../views/security_setting_page.dart';
import '../views/theme_select_page.dart';
import '../views/wallet_setting_page.dart';
import '/core/constants/storage_keys.dart';
import '/core/constants/app_colors.dart';

class SettingsController extends GetxController {
  // 主题状态（响应式）
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  // 当前主题对应的颜色方案（响应式）
  final Rx<AppColorScheme> currentColors = Rx<AppColorScheme>(AppColors.light);

  @override
  void onInit() {
    super.onInit();
    // 初始化时加载主题设置
    _loadThemeSetting();
    // 监听主题模式变化，同步更新颜色方案
    ever(themeMode, (ThemeMode mode) {
      _updateColorScheme(mode);
    });
  }

  // 加载本地保存的主题设置
  Future<void> _loadThemeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode.value = ThemeMode.values[prefs.getInt(StorageKeys.themeMode) ?? 0];
  }

  // 更新当前颜色方案
  void _updateColorScheme(ThemeMode mode) {
    currentColors.value = mode == ThemeMode.dark ? AppColors.dark : AppColors.light;
  }

  // ================ 公开方法 ================

  /// 导航到设置页面
  void navigateToWalletSettingPage() {
    Get.to(() => const WalletSettingPage());
  } 

  /// 导航到语言设置页面
  void navigateToLanguageSelectPage() {
    Get.to(() => const LanguageSelectPage());
  }

  /// 导航到货币设置页面
  void navigateToCurrencySettingPage() {
    Get.to(() => const CurrencySelectPage());
  }

  /// 导航到安全设置页面
  void navigateToSecuritySettingPage() {
    Get.to(() => const SecuritySettingPage());
  }

  /// 导航到地址簿页面
  void navigateToAddressBookPage() {
    Get.to(() => const AddressBookPage());
  }

  /// 导航到主题设置页面
  void navigateToThemeSelectPage() {
    Get.to(() => const ThemeSelectPage());
  }

  /// 导航到关于我们页面
  void navigateToAboutPage() {
    Get.to(() => const AboutUsPage());
  }

  /// 切换主题模式
  // void toggleThemeMode() {
  //   themeMode.value = themeMode.value == ThemeMode.system
  //       ? ThemeMode.light
  //       : themeMode.value == ThemeMode.light
  //           ? ThemeMode.dark
  //           : ThemeMode.system;
  //   // 保存新的主题模式到本地
  //   _saveThemeSetting(themeMode.value);
  // }

  // // 保存主题模式到本地
  // Future<void> _saveThemeSetting(ThemeMode mode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(StorageKeys.themeMode, mode.index);
  // }
}