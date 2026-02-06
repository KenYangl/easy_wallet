import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/select_item.dart';
import '/core/utils/getx_extensions.dart';

class LanguageSelectPage extends StatelessWidget {
  const LanguageSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 当前选中的语言（从 GetX 控制器获取）
    final currentLocale = Get.locale ?? const Locale('zh', 'CN');

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
          '选择语言',
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
              // 简体中文
              SelectItem(
                title: '简体中文',
                isSelected: currentLocale == const Locale('zh', 'CN'),
                onTap: () {
                  Get.updateLocale(const Locale('zh', 'CN'));
                  Get.back();
                },
              ),
              // English
              SelectItem(
                title: 'English',
                isSelected: currentLocale == const Locale('en', 'US'),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
              // 繁体中文
              SelectItem(
                title: '繁体中文',
                isSelected: currentLocale == const Locale('zh', 'TW'),
                onTap: () {
                  Get.updateLocale(const Locale('zh', 'TW'));
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}