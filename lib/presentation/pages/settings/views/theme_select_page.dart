import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/select_item.dart';
import '/core/utils/getx_extensions.dart';
import '/presentation/pages/app/app_controller.dart';

class ThemeSelectPage extends StatelessWidget {
  const ThemeSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Scaffold(
      backgroundColor: Get.appColors.value.background,
      appBar: AppBar(
        backgroundColor: Get.appColors.value.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Get.appColors.value.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          '主题模式',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Get.appColors.value.textPrimary,
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
              // 主题跟随系统
              Obx(() {
                return SelectItem(
                  title: '主题跟随系统',
                  subtitle: '开启后，主题模式将跟随系统设置为深色模式或浅色模式',
                  isSelected: appController.themeMode.value == ThemeMode.system,
                  onTap: () {
                    appController.updateThemeMode(ThemeMode.system);
                    Get.back();
                  },
                );
              }),
              // 暗夜模式
              Obx(() {
                return SelectItem(
                  title: '暗夜模式',
                  isSelected: appController.themeMode.value == ThemeMode.dark,
                  onTap: () {
                    appController.updateThemeMode(ThemeMode.dark);
                    Get.back();
                  },
                );
              }),
              // 白天模式
              Obx(() {
                return SelectItem(
                  title: '白天模式',
                  isSelected: appController.themeMode.value == ThemeMode.light,
                  onTap: () {
                    appController.updateThemeMode(ThemeMode.light);
                    Get.back();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}