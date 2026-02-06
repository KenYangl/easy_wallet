## Easy Wallet

一个用于练习 Flutter、GetX、Hive 等技术栈的去中心化钱包类应用 demo。

---

### **lib 目录结构说明**

```text
lib/
├── main.dart                  # 应用入口：初始化本地存储、注册依赖、配置 GetMaterialApp
├── routes/
│   └── app_routes.dart        # 路由常量 & GetX 路由表（GetPage 列表）
├── core/                      # 核心基础能力（不会依赖业务）
│   ├── bindings/
│   │   └── initial_bindings.dart    # 全局依赖注入：注册控制器、服务等 GetX Binding
│   ├── config/
│   │   ├── environment.dart        # 环境配置实体（dev/prod 等）
│   │   └── environment_manager.dart# 当前环境管理、切换逻辑
│   ├── constants/
│   │   ├── app_colors.dart         # 全局颜色常量
│   │   └── storage_keys.dart       # SharedPreferences/Hive 等存储 key 常量
│   ├── lang/
│   │   ├── en.dart                 # 英文文案
│   │   ├── zh.dart                 # 中文文案
│   │   └── translation.dart        # GetX Translations，多语言配置入口
│   ├── services/
│   │   └── network_service.dart    # 网络服务封装（请求、错误处理等）
│   └── utils/
│       └── getx_extensions.dart    # GetX 相关扩展方法 / 工具函数
├── data/                      # 数据层（模型、接口、数据库）
│   ├── models/
│   │   ├── wallet_model.dart       # 钱包信息模型
│   │   └── wallet_balance.dart     # 钱包余额/资产模型
│   ├── remote/
│   │   ├── api_client.dart         # 网络客户端封装（baseUrl、拦截等）
│   │   └── wallet_api.dart         # 钱包相关接口定义
│   └── database/
│       ├── secure_storage.dart     # 安全存储（如私钥、助记词）
│       ├── local_database.dart     # 本地数据库封装（Hive 等）
│       └── cache_manager.dart      # 缓存管理
├── presentation/              # 表现层（UI + 控制器）
│   ├── pages/
│   │   ├── app/
│   │   │   ├── app_page.dart       # 整个应用的 Shell / 根页面（底部导航等）
│   │   │   └── app_controller.dart # 根页面控制器：当前 Tab、全局状态
│   │   ├── onboarding/             # 首次启动 / 创建导入钱包流程
│   │   │   ├── controllers/
│   │   │   │   ├── onboarding_controller.dart         # 引导页控制器
│   │   │   │   ├── create_wallet_controller.dart      # 创建钱包逻辑
│   │   │   │   ├── import_wallet_controller.dart      # 导入钱包逻辑
│   │   │   │   └── backup_wallet_tips_controller.dart # 备份提示逻辑
│   │   │   ├── views/
│   │   │   │   ├── onboarding_page.dart               # 引导首页
│   │   │   │   ├── create_wallet_page.dart            # 创建钱包页
│   │   │   │   ├── import_wallet_page.dart            # 导入钱包页
│   │   │   │   └── backup_wallet_tips_page.dart       # 备份提示页
│   │   │   └── widgets/
│   │   │       ├── onboarding_carousel.dart           # 引导轮播组件
│   │   │       └── onboarding_card.dart               # 引导卡片组件
│   │   ├── home/                   # 钱包首页
│   │   │   ├── controllers/
│   │   │   │   └── home_controller.dart               # 首页业务逻辑
│   │   │   ├── views/
│   │   │   │   ├── home_page.dart                     # 首页主界面
│   │   │   │   ├── select_wallet_page.dart            # 选择钱包
│   │   │   │   ├── scan_qr_code_page.dart             # 扫码/收款
│   │   │   │   └── message_page.dart                  # 消息中心
│   │   │   └── widgets/
│   │   │       └── home_navigation_bar.dart           # 首页自定义底部导航栏
│   │   ├── swap/
│   │   │   └── views/swap_page.dart                   # 闪兑/Swap 页面
│   │   ├── settings/               # 设置相关页面
│   │   │   ├── controllers/
│   │   │   │   └── settings_controller.dart           # 设置页控制器
│   │   │   ├── views/
│   │   │   │   ├── settings_page.dart                 # 设置首页
│   │   │   │   ├── security_setting_page.dart         # 安全设置
│   │   │   │   ├── wallet_setting_page.dart           # 钱包设置
│   │   │   │   ├── address_book_page.dart             # 地址簿
│   │   │   │   ├── language_select_page.dart          # 语言切换
│   │   │   │   ├── currency_select_page.dart          # 法币单位选择
│   │   │   │   └── theme_select_page.dart             # 主题选择
│   │   │   └── widgets/
│   │   │       ├── setting_item.dart                  # 设置项通用 cell
│   │   │       └── select_item.dart                   # 通用选择 cell
│   │   ├── discover/
│   │   │   └── discover_page.dart                     # 发现/活动 页
│   │   └── defi/
│   │       └── defi_page.dart                         # DeFi 功能入口页
│   └── widgets/               # 可复用通用组件
│       ├── action_buttons/
│       │   ├── primary_button.dart                    # 主按钮样式
│       │   ├── secondary_button.dart                  # 次按钮样式
│       │   └── function_icon_button.dart              # 图标功能按钮
│       └── cells/
│           └── token_item.dart                        # 资产/代币列表 Cell

```

---

### **主要功能说明**

- **应用启动 & 依赖初始化**
  - `main.dart` 中初始化 `SharedPreferences`、`Hive` 等本地存储
  - 使用 `InitialBindings` 统一注册 GetX 控制器和服务
  - 通过 `AppRoutes` 和 `GetMaterialApp` 管理路由

- **多语言 & 主题**
  - `core/lang/*` 提供中英双语文案，`Translation` 接入 GetX 国际化
  - 支持浅色/深色主题，主题配置集中在 `main.dart` 中

- **数据持久化**
  - Hive + 自定义 `local_database.dart` / `secure_storage.dart` 做本地数据 & 安全存储
  - `cache_manager.dart` 管理通用缓存逻辑

- **业务功能模块**
  - `onboarding`：创建/导入钱包、备份提示，引导用户完成首次使用
  - `home`：钱包首页，展示余额、资产列表、自定义底部导航等
  - `swap`：闪兑页面（兑换/交易入口）
  - `settings`：安全设置、钱包设置、语言/货币/主题切换等
  - `discover` & `defi`：发现页和 DeFi 功能入口，便于后续扩展更多业务

### **运行项目**

```bash
flutter pub get
flutter run
```

### **后续可以继续扩展的方向**

- 在 `home_page.dart` 中补充资产列表、K 线、余额等 UI
- 在 `card_page.dart` 中实现卡片管理/展示
- 在 `exchange_page.dart` 中实现闪兑流程
- 在 `defi_page.dart` 中展示 DeFi 产品列表
- 在 `discover_page.dart` 中做发现/活动/公告等
