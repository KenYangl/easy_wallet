import 'package:flutter/material.dart';

/// 通用引导卡片组件
/// 只需要传入图片和文字即可快速生成
class OnboardingCard extends StatelessWidget {
  // 图片路径（支持本地资源或网络图片）
  final String imagePath;
  // 底部显示的文字
  final String title;
  // 是否为网络图片（默认false，使用本地资源）
  final bool isNetworkImage;
  // 图片宽度（默认210）
  final double imageWidth;
  // 图片高度（默认210）
  final double imageHeight;

  const OnboardingCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.isNetworkImage = false,
    this.imageWidth = 210,
    this.imageHeight = 210,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 图片区域
        isNetworkImage
            ? Image.network(
                imagePath,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
              )
            : Image.asset(
                imagePath,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
        const SizedBox(height: 24),
        // 文字区域
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}