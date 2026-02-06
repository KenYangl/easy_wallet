import 'package:flutter/material.dart';
import '/core/constants/app_colors.dart';

class HomeNavigationBar extends StatefulWidget {

  final String walletName;          // 钱包名称
  final String? avatarAsset;        // 头像图片路径（可选）
  final Function()? onWalletTap;    // 钱包区域点击回调
  final Function()? onCopyTap;     // 复制钱包地址点击回调
  final Function()? onNotificationTap; // 通知图标点击回调
  final Function()? onQrCodeTap;   // 二维码图标点击回调
  final Function()? onSettingsTap;  // 设置图标点击回调

  // 构造函数
  const HomeNavigationBar({
    super.key,
    this.walletName = 'Wallet1',
    this.avatarAsset,
    this.onWalletTap,
    this.onCopyTap,
    this.onNotificationTap,
    this.onQrCodeTap,
    this.onSettingsTap,
  });

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: colors.backgroundApp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧：钱包头像 + 名称
          _buildWalletSection(colors),
          
          // 右侧：功能图标（通知、二维码、设置）
          _buildFunctionIcons(colors),
        ],
      ),
    );
  }

  // 构建钱包区域（头像 + 名称）
  Widget _buildWalletSection(AppColorScheme colors) {
    return GestureDetector(
      onTap: widget.onWalletTap, // 钱包区域点击回调
      child: Row(
        children: [
          // 头像（支持自定义图片或默认圆形）
          CircleAvatar(
            radius: 16,
            backgroundImage: widget.avatarAsset != null 
                ? AssetImage(widget.avatarAsset!) 
                : null,
            child: widget.avatarAsset == null 
                ? const Icon(Icons.account_balance_wallet, size: 16) 
                : null,
          ),
          
          const SizedBox(width: 8),
          
          // 钱包名称 + 下拉箭头
          Row(
            children: [
              Text(
                widget.walletName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  // 构建右侧功能图标
  Widget _buildFunctionIcons(AppColorScheme colors) {
    return Row(
      children: [
        // 通知图标
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          icon: Icon(Icons.notifications_none, color: colors.textPrimary),
          onPressed: widget.onNotificationTap,
        ),
        
        const SizedBox(width: 16),
        
        // 二维码图标
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          icon: Icon(Icons.qr_code, color: colors.textPrimary),
          onPressed: widget.onQrCodeTap,
        ),
        
        const SizedBox(width: 16),
        
        // 设置图标
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          icon: Icon(Icons.settings, color: colors.textPrimary),
          onPressed: widget.onSettingsTap,
        ),
      ],
    );
  }
}