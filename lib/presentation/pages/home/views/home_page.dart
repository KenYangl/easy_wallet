import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/presentation/pages/home/controllers/home_controller.dart';
import '/presentation/widgets/cells/token_item.dart';
import '/presentation/widgets/action_buttons/function_icon_button.dart';
import '/core/constants/app_colors.dart';
import '/presentation/pages/home/widgets/home_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final homeController = Get.put(HomeController());

    return Scaffold(
      appBar: _buildTopNavigationBar(colors),
      backgroundColor: colors.backgroundApp,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 顶部导航
                const SizedBox(height: 8),
                
                // const SizedBox(height: 24),

                // 总资产
                Text(
                  '\$109.35',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),
                
                Text(
                  '+',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 32),

                // 功能按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FunctionIconButton(
                      icon: Icons.arrow_upward,
                      label: '转账',
                      onPressed: () {},
                    ),
                    FunctionIconButton(
                      icon: Icons.arrow_downward,
                      label: '收款',
                      onPressed: () {},
                    ),
                    FunctionIconButton(
                      icon: Icons.swap_horiz,
                      label: '购买',
                      onPressed: () {},
                    ),
                    FunctionIconButton(
                      icon: Icons.history,
                      label: '交易历史',
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 银行卡横幅
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BANK NAME',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'No transaction fee for redemption\nwith this card',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 币种/NFT 标签
                Row(
                  children: [
                    Text(
                      '币种',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'NFT',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.add_circle_outline, color: colors.textPrimary),
                  ],
                ),
                const SizedBox(height: 16),

                // Token 列表
                Column(
                  children: [
                    TokenItem(
                      // icon: 'assets/icons/btc.png',
                      name: 'BTC',
                      symbol: 'Bitcoin',
                      price: '7,198',
                      change: '+1.23',
                      balance: '87.98',
                      isPositiveChange: true,
                    ),
                    TokenItem(
                      // icon: 'assets/icons/btc.png',
                      name: 'BTC',
                      symbol: 'Bitcoin',
                      price: '7,198',
                      change: '+1.23',
                      balance: '87.98',
                      isPositiveChange: true,
                    ),
                    TokenItem(
                      // icon: 'assets/icons/btt.png',
                      name: 'BTT',
                      symbol: 'BitTorrent',
                      price: '7,198',
                      change: '-1.23',
                      balance: '87.98',
                      isPositiveChange: false,
                    ),
                    TokenItem(
                      // icon: 'assets/icons/trx.png',
                      name: 'TRX',
                      symbol: 'TRON',
                      price: '7,198',
                      change: '+1.23',
                      balance: '87.98',
                      isPositiveChange: true,
                    ),
                    TokenItem(
                      // icon: 'assets/icons/usdt.png',
                      name: 'USDT',
                      symbol: 'Tether',
                      price: '7,198',
                      change: '+1.23',
                      balance: '87.98',
                      isPositiveChange: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  /// 构建顶部导航栏
  PreferredSizeWidget _buildTopNavigationBar(AppColorScheme colors) {
    final homeController = Get.find<HomeController>();
    return AppBar(
        backgroundColor: colors.backgroundApp,
        elevation: 0, // 移除顶部阴影
        toolbarHeight: 44,
        automaticallyImplyLeading: false, // 去掉默认的返回箭头
        titleSpacing: 0, // 去掉标题的默认间距
        title: HomeNavigationBar(
          walletName: 'Wallet1',
          onWalletTap: () {
            // 处理钱包点击事件
            homeController.navigateToSelectWalletPage();
          },
          onCopyTap: () {
            // 处理复制钱包地址点击事件
            homeController.navigateToCopyAddressPage();
          },
          onNotificationTap: () {
            // 处理通知点击事件
            homeController.navigateToMessagePage();
          },
          onQrCodeTap: () {
            // 处理二维码点击事件
            homeController.navigateToScanQRCodePage();
          },
          onSettingsTap: () {
            // 处理设置点击事件
            homeController.navigateToSettingsPage();
          },
        ),
      );
  }
}