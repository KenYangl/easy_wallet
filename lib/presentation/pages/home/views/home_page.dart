import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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

  // 模拟数据
  final List<TokenItem> tokens = const [
    TokenItem(
      name: 'BTC',
      symbol: 'Bitcoin',
      price: '7,198',
      change: '+1.23',
      balance: '87.98',
      isPositiveChange: true,
    ),
    TokenItem(
      name: 'BTC',
      symbol: 'Bitcoin',
      price: '7,198',
      change: '+1.23',
      balance: '87.98',
      isPositiveChange: true,
    ),
    TokenItem(
      name: 'BTT',
      symbol: 'BitTorrent',
      price: '7,198',
      change: '-1.23',
      balance: '87.98',
      isPositiveChange: false,
    ),
    TokenItem(
      name: 'TRX',
      symbol: 'TRON',
      price: '7,198',
      change: '+1.23',
      balance: '87.98',
      isPositiveChange: true,
    ),
    TokenItem(
      name: 'USDT',
      symbol: 'Tether',
      price: '7,198',
      change: '+1.23',
      balance: '87.98',
      isPositiveChange: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // 创建 TabController，使用 this (SingleTickerProviderStateMixin) 作为 vsync
    _tabController = TabController(vsync: this, length: 2);
    // 监听 Tab 切换事件（示例：动态处理标签切换）
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.dispose(); // 必须销毁 TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final homeController = Get.put(HomeController());

    return Scaffold(
      appBar: _buildTopNavigationBar(colors),
      backgroundColor: colors.backgroundApp,
      body: CustomScrollView(
        slivers: [
          // 总资产区域
          SliverToBoxAdapter(
            child: _buildAssetSection(colors),
          ),

          const SizedBox(height: 16),

          // 转账/收款/购买/交易历史 按钮区域
          SliverToBoxAdapter(
            child: _buildFunctionSection(colors, homeController),
          ),

          const SizedBox(height: 16),

          // 轮播图区域
          SliverToBoxAdapter(
            child: _buildCarouselSection(colors),
          ),

          // 粘性头部（币种/NFT 标签）
          SliverStickyHeader(
            header: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              color: colors.backgroundApp,
              child: TabBar(
                controller: _tabController,
                labelColor: colors.brandPrimary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: colors.indicatorActive,
                indicatorWeight: 4.0,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                tabs: const [
                  Tab(text: '币种'),
                  Tab(text: 'NFT'),
                ],
              ),
            ),
            sliver: SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 币种标签页（动态 ListView）
                  _buildTokenListView(colors),
                  // NFT标签页（可动态加载）
                  _buildNftTabView(colors),
                ],
              ),
            )
          )
        ],
      )
    );
  }

  // ================ 私有方法 ================

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
            homeController.navigateToAddressPage();
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

  /// 构建总资产区域
  Widget _buildAssetSection(AppColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      color: colors.indicatorActive,
      child: Column(
        children: const [
          Text(
            '总资产',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '¥ 12,345.67',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// 构建转账/收款/购买/交易历史 按钮区域
  Widget _buildFunctionSection(AppColorScheme colors, HomeController homeController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFunctionButton(colors, '转账', Icons.send, onPressed: () {
            // 处理转账按钮点击事件
            homeController.navigateToSendPage();
          }),
          _buildFunctionButton(colors, '收款', Icons.arrow_upward, onPressed: () {
            // 处理收款按钮点击事件
            homeController.navigateToReceivePage();
          }),
          _buildFunctionButton(colors, '购买', Icons.shopping_cart, onPressed: () {
            // 处理购买按钮点击事件
            homeController.navigateToBuyPage();
          }),
          _buildFunctionButton(colors, '交易历史', Icons.history, onPressed: () {
            // 处理交易历史按钮点击事件
            homeController.navigateToTransactionHistoryPage();
          }),
        ],
      ),
    );
  }

  /// 构建功能按钮
  Widget _buildFunctionButton(AppColorScheme colors, String text, IconData icon, {VoidCallback? onPressed}) {
    return FunctionIconButton(
      icon: icon,
      label: text,
      onPressed: onPressed ?? () {
        debugPrint('点击了 $text 按钮');
      },
    );
  }

  /// 构建轮播图区域
  Widget _buildCarouselSection(AppColorScheme colors) {
    return Container(
      height: 200,
      color: colors.indicatorActive,
      child: const Center(
        child: Text(
          '轮播图区域',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  // Tab 切换回调（动态处理业务逻辑）
  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      final currentTab = _tabController.index == 0 ? '币种' : 'NFT';
      debugPrint('切换到 $currentTab 标签');
    }
  }

  /// 构建币种标签页（动态 ListView）
  Widget _buildTokenListView(AppColorScheme colors) {
    return ListView.builder(
      itemCount: tokens.length,
      itemBuilder: (context, index) => TokenItem(
        name: tokens[index].name,
        symbol: tokens[index].symbol,
        price: tokens[index].price,
        change: tokens[index].change,
        balance: tokens[index].balance,
        isPositiveChange: tokens[index].isPositiveChange,
      ),
    );
  }

  // NFT 标签页（可动态加载）
  Widget _buildNftTabView(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.collections, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            '暂无NFT资产',
            style: TextStyle(color: colors.textPrimary, fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              // 动态触发NFT相关操作
              debugPrint('去购买NFT');
            },
            child: const Text('去购买'),
          ),
        ],
      ),
    );
  }
}