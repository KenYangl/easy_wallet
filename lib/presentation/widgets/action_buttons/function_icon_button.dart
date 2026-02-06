import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_wallet/core/utils/getx_extensions.dart';

/// 通用功能图标按钮（带文字说明）
class FunctionIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final double? iconSize;
  final double? buttonSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? labelColor;

  const FunctionIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconSize = 24,
    this.buttonSize = 64,
    this.backgroundColor,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colors = Get.appColors.value;
      // 优先使用传入的颜色，否则使用主题默认颜色
      final bgColor = backgroundColor ?? Colors.grey.shade50;
      final iconCol = iconColor ?? colors.textPrimary;
      final labelCol = labelColor ?? colors.textPrimary;

      return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 图标背景
            Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: iconCol,
              ),
            ),
            const SizedBox(height: 8),
            // 文字说明
            Text(
              label,
              style: TextStyle(
                color: labelCol,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    });
  }
}