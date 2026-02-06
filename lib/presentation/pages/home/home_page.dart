import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_wallet/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/widgets/cells/token_item.dart';
import '/presentation/widgets/action_buttons/function_icon_button.dart';
import '/core/utils/getx_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.appColors.value.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 顶部导航
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          // backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Wallet1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Get.appColors.value.textPrimary,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.notifications_none, color: Get.appColors.value.textPrimary),
                        const SizedBox(width: 16),
                        Icon(Icons.qr_code, color: Get.appColors.value.textPrimary),
                        const SizedBox(width: 16),
                        Icon(Icons.settings, color: Get.appColors.value.textPrimary),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 总资产
                Text(
                  '\$109.35',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Get.appColors.value.textPrimary,
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
                              color: Get.appColors.value.textPrimary,
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
                        color: Get.appColors.value.textPrimary,
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
                    Icon(Icons.add_circle_outline, color: Get.appColors.value.textPrimary),
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
      ),
      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color(0xFF80E8FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: '闪兑',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_board),
            label: 'DeFi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
        ],
      ),
    );
  }
}