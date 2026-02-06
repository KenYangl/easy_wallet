import 'package:easy_wallet/presentation/pages/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/storage_keys.dart';
import 'core/lang/translation.dart';
import 'routes/app_routes.dart';
import 'core/bindings/initial_bindings.dart';
import 'presentation/pages/onboarding/views/onboarding_page.dart';
import 'presentation/pages/home/home_page.dart';

void main() async {
  // 初始化Flutter绑定（确保在runApp之前）
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 初始化本地存储
  await SharedPreferences.getInstance();
  await Hive.initFlutter();
  // 注册Hive适配器（后续添加模型后启用）
  // Hive.registerAdapter(WalletModelAdapter());
  await Hive.openBox('wallet_box');

  // 2. 判断钱包状态
  // final prefs = await SharedPreferences.getInstance();
  // final hasWallet = prefs.getBool(StorageKeys.hasWallet) ?? false;

  // 初始化绑定
  // InitialBindings().dependencies();

  // 3. 启动应用
  const String initialRoute = AppRoutes.onboarding;
  runApp(const MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easy Wallet',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      initialBinding: InitialBindings(), // GetX全局依赖绑定
      // 多语言配置
      translations: Translation(), // 国际化翻译
      locale: Get.deviceLocale, // 默认使用设备语言
      fallbackLocale: const Locale('zh', 'CN'), // 语言解析失败时的备用语言
      // 主题配置
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: ThemeMode.light,
      // 路由配置
      getPages: AppRoutes.getPages,
    );
  }
}