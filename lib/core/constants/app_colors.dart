import 'package:flutter/material.dart';

/// 应用颜色常量（按主题分类）
class AppColors {
  // 亮色模式颜色
  static const light = _LightColors();
  // 暗黑模式颜色
  static const dark = _DarkColors();

  /// 根据当前主题获取对应颜色
  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? light : dark;
  }
}

/// 基础颜色模板
abstract class AppColorScheme {
  /// 品牌主色
  Color get brandPrimary;
  // 文字主色
  Color get textPrimary;
  // 按钮主色（创建钱包）
  Color get primaryButtonBg;
  // 按钮次要色（导入钱包边框）
  Color get secondaryButtonBorder;
  // 背景色
  Color get backgroundApp;
  // 指示器激活色
  Color get indicatorActive;
  // 指示器未激活色
  Color get indicatorInactive;
}

/// 亮色模式颜色
class _LightColors implements AppColorScheme {
  const _LightColors();

  @override
  Color get brandPrimary => const Color(0xFF61EEF7);
  @override
  Color get textPrimary => const Color(0xFF001F29);
  @override
  Color get primaryButtonBg => const Color(0xFF80E8FF);
  @override
  Color get secondaryButtonBorder => const Color(0xFF80E8FF);
  @override
  Color get backgroundApp => Colors.white;
  @override
  Color get indicatorActive => const Color(0xFF80E8FF);
  @override
  Color get indicatorInactive => Colors.grey.shade300;
}

/// 暗黑模式颜色
class _DarkColors implements AppColorScheme {
  const _DarkColors();

  @override
  Color get brandPrimary => const Color(0xFF61EEF7);
  @override
  Color get textPrimary => Colors.white; // #FFFFFF
  @override
  Color get primaryButtonBg => const Color(0xFF00A3BF); // 暗黑模式按钮稍深
  @override
  Color get secondaryButtonBorder => const Color(0xFF00A3BF);
  @override
  Color get backgroundApp => const Color(0xFF121212);
  @override
  Color get indicatorActive => const Color(0xFF00A3BF);
  @override
  Color get indicatorInactive => Colors.grey.shade700;
}