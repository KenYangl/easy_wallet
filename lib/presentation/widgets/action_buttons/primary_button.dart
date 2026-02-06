import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/constants/app_colors.dart';
import '/core/utils/getx_extensions.dart';

/// 通用主按钮
/// 背景颜色: enable #61EEF7 蓝色, disable ##DCE5E5 灰色
/// 字体颜色: enable #001F29 黑色, disable #B2BBBD 深灰色
/// 圆角: 高度的一半
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 45,
    this.borderRadius = 22.5,
  });

  @override
  Widget build(BuildContext context) {
    final AppColorScheme colors = Get.appColors.value;
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brandPrimary,
          foregroundColor: colors.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}