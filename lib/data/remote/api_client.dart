import 'package:get/get.dart';
import '/core/services/network_service.dart';

/// API客户端基类
abstract class ApiClient {
  final NetworkService _network = NetworkService.instance;

  /// 获取完整URL
  String getFullUrl(String endpoint) {
    return endpoint;
  }

  /// GET请求
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? fromJson,
  }) async {
    return _network.get<T>(
      path: endpoint,
      queryParameters: queryParams,
      fromJsonT: fromJson,
    );
  }

  /// POST请求
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? fromJson,
  }) async {
    return _network.post<T>(
      path: endpoint,
      data: data,
      queryParameters: queryParams,
      fromJsonT: fromJson,
    );
  }
}