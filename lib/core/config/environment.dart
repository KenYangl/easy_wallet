/// 环境类型枚举
enum Environment {
  test,
  development,
  uat,
  production,
}

/// 环境配置模型
class EnvironmentConfig {
  final Environment environment;
  final String name;
  final String baseUrl;
  final String apiKey;
  final bool enableLogging;
  final bool enableCache;
  final String version;

  EnvironmentConfig({
    required this.environment,
    required this.name,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.enableCache,
    required this.version,
  });

  /// 是否是开发环境
  bool get isDevelopment => environment == Environment.development;

  /// 是否是测试环境
  bool get isTest => environment == Environment.test;

  /// 是否是UAT环境
  bool get isUat => environment == Environment.uat;

  /// 是否是生产环境
  bool get isProduction => environment == Environment.production;

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'environment': environment.name,
      'name': name,
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'enableLogging': enableLogging,
      'enableCache': enableCache,
      'version': version,
    };
  }
}