import 'package:easy_wallet/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import '../widgets/setting_item.dart';

import '/presentation/pages/app/app_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final settingsController = Get.find<SettingsController>();

    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundApp,
      appBar: AppBar(
        backgroundColor: colors.backgroundApp,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          '设置',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // 钱包设置
              SettingItem(
                icon: Icons.account_balance_wallet,
                title: '钱包设置',
                onTap: () {
                  // 跳转到钱包设置页面
                  settingsController.navigateToWalletSettingPage();
                },
              ),
              // 语言
              SettingItem(
                icon: Icons.language,
                title: '语言',
                subtitle: '简体中文',
                onTap: () {
                  // 跳转到语言设置页面
                  settingsController.navigateToLanguageSelectPage();
                },
              ),
              // 货币
              SettingItem(
                icon: Icons.attach_money,
                title: '货币',
                subtitle: 'USD',
                onTap: () {
                  // 跳转到货币设置页面
                  settingsController.navigateToCurrencySettingPage();
                },
              ),
              // 安全
              SettingItem(
                icon: Icons.security,
                title: '安全',
                onTap: () {
                  // 跳转到安全设置页面
                  settingsController.navigateToSecuritySettingPage();
                },
              ),
              // 地址簿
              SettingItem(
                icon: Icons.contacts,
                title: '地址簿',
                onTap: () {
                  // 跳转到地址簿页面
                  settingsController.navigateToAddressBookPage();
                },
              ),
              // 主题模式
              Obx(() {
                String themeText;
                switch (appController.themeMode.value) {
                  case ThemeMode.light:
                    themeText = '亮色模式';
                    break;
                  case ThemeMode.dark:
                    themeText = '暗黑模式';
                    break;
                  case ThemeMode.system:
                    themeText = '跟随系统';
                    break;
                }
                return SettingItem(
                  icon: Icons.palette,
                  title: '主题模式',
                  subtitle: themeText,
                  onTap: () {
                    // 跳转到主题设置页面
                    settingsController.navigateToThemeSelectPage();
                  },
                );
              }),
              // 关于我们
              SettingItem(
                icon: Icons.info_outline,
                title: '关于我们',
                onTap: () {
                  // 跳转到关于我们页面
                  settingsController.navigateToAboutPage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}