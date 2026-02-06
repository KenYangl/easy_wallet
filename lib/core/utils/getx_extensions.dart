import 'package:get/get.dart';
import 'package:easy_wallet/presentation/pages/app/app_controller.dart';
import 'package:easy_wallet/core/constants/app_colors.dart';

/// GetX 扩展方法：一键获取当前主题颜色
extension GetColorExtension on GetInterface {
  // 获取响应式的颜色方案（用于 Obx 监听）
  Rx<AppColorScheme> get appColors => Get.find<AppController>().currentColors;

  // 获取当前颜色方案（非响应式，用于非 Widget 类）
  AppColorScheme get currentAppColors => Get.find<AppController>().currentColors.value;
}