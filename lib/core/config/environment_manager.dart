import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; 
import '/core/services/network_service.dart';
import 'environment.dart';

/// 环境配置管理
class EnvironmentManager {
  static EnvironmentManager? _instance;
  static EnvironmentManager get instance => _instance!;

  late EnvironmentConfig _currentConfig;
  EnvironmentConfig get currentConfig => _currentConfig;

  final Rx<Environment> currentEnvironment = Environment.production.obs;

  /// 私有构造函数
  EnvironmentManager._internal();

  /// 初始化环境配置
  static Future<EnvironmentManager> init({
    Environment? environment,
  }) async {
    _instance ??= EnvironmentManager._internal();
    
    // 确定当前环境
    final env = environment ?? await _determineEnvironment();
    
    // 加载对应环境的配置
    _instance!._currentConfig = _loadConfig(env);
    
    return _instance!;
  }

  /// 确定当前环境
  static Future<Environment> _determineEnvironment() async {
    // 1. 首先检查是否通过命令行参数指定
    final String? envFromArgs = Get.parameters['env'];
    if (envFromArgs != null) {
      return _parseEnvironment(envFromArgs);
    }

    // 2. 检查是否通过环境变量指定（Flutter run时可以使用 --dart-define）
    const String? envFromDefine = String.fromEnvironment('APP_ENV');
    if (envFromDefine != null && envFromDefine.isNotEmpty) {
      return _parseEnvironment(envFromDefine);
    }

    // 3. 从本地存储读取上次设置的环境
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEnv = prefs.getString('environment');
      if (savedEnv != null) {
        return _parseEnvironment(savedEnv);
      }
    } catch (e) {
      print('Error reading environment from storage: $e');
    }

    // 4. 默认环境（根据编译模式）
    return kDebugMode ? Environment.development : Environment.production;
  }

  /// 解析环境字符串
  static Environment _parseEnvironment(String envStr) {
    switch (envStr.toLowerCase()) {
      case 'test':
      case 'testing':
        return Environment.test;
      case 'dev':
      case 'development':
        return Environment.development;
      case 'uat':
      case 'staging':
        return Environment.uat;
      case 'prod':
      case 'production':
        return Environment.production;
      default:
        return kDebugMode ? Environment.development : Environment.production;
    }
  }

  /// 加载对应环境的配置
  static EnvironmentConfig _loadConfig(Environment environment) {
    switch (environment) {
      case Environment.test:
        return _testConfig;
      case Environment.development:
        return _devConfig;
      case Environment.uat:
        return _uatConfig;
      case Environment.production:
        return _prodConfig;
    }
  }

  // ============ 各环境具体配置 ============

  /// 测试环境配置
  static EnvironmentConfig get _testConfig {
    return EnvironmentConfig(
      environment: Environment.test,
      name: 'Test',
      baseUrl: 'https://test-api.easywallet.com',
      apiKey: 'test_api_key_123',
      enableLogging: true,
      enableCache: false,
      version: '1.0.0-test',
    );
  }

  /// 开发环境配置
  static EnvironmentConfig get _devConfig {
    return EnvironmentConfig(
      environment: Environment.development,
      name: 'Development',
      baseUrl: 'https://dev-api.easywallet.com',
      apiKey: 'dev_api_key_456',
      enableLogging: true,
      enableCache: false,
      version: '1.0.0-dev',
    );
  }

  /// UAT环境配置
  static EnvironmentConfig get _uatConfig {
    return EnvironmentConfig(
      environment: Environment.uat,
      name: 'UAT',
      baseUrl: 'https://uat-api.easywallet.com',
      apiKey: 'uat_api_key_789',
      enableLogging: true,
      enableCache: true,
      version: '1.0.0-uat',
    );
  }

  /// 生产环境配置
  static EnvironmentConfig get _prodConfig {
    return EnvironmentConfig(
      environment: Environment.production,
      name: 'Production',
      baseUrl: 'https://api.easywallet.com',
      apiKey: 'prod_api_key_secured',
      enableLogging: false, // 生产环境关闭详细日志
      enableCache: true,
      version: '1.0.0',
    );
  }

  /// 切换环境（主要用于开发调试）
  Future<void> switchEnvironment(Environment environment) async {
    if (currentConfig.isProduction && kReleaseMode) {
      // 生产版本不允许切换环境
      throw Exception('Cannot switch environment in production build');
    }

    _currentConfig = _loadConfig(environment);
    currentEnvironment.value = environment;

    // 保存到本地存储
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('environment', environment.name);
    } catch (e) {
      print('Error saving environment: $e');
    }

    // 通知网络服务更新配置
    _notifyEnvironmentChanged();
  }

  /// 通知环境变化
  void _notifyEnvironmentChanged() {
    // 通知所有监听者环境已改变
    // 这里可以使用 GetX 的 Event Bus 或者直接调用服务
    if (Get.isRegistered<NetworkService>()) {
      final networkService = Get.find<NetworkService>();
      networkService.updateBaseUrl(_currentConfig.baseUrl);
      // networkService.updateApiKey(_currentConfig.apiKey);
    }
  }

  /// 获取所有环境配置（用于环境切换UI）
  static Map<Environment, EnvironmentConfig> getAllConfigs() {
    return {
      Environment.test: _testConfig,
      Environment.development: _devConfig,
      Environment.uat: _uatConfig,
      Environment.production: _prodConfig,
    };
  }

  /// 获取当前环境信息字符串
  String get environmentInfo {
    return '${_currentConfig.name} (${_currentConfig.baseUrl})';
  }
}