import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:dio/src/response.dart' as DioResponse;
import 'package:flutter/foundation.dart';
import '/data/database/cache_manager.dart';
import '/core/config/environment.dart';

/// HTTP 方法枚举
enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
}

/// 网络响应状态码
class HttpStatus {
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
  static const int serviceUnavailable = 503;
}

/// API 响应基础模型
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  final bool success;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    required this.success,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse(
      code: json['code'] ?? json['status'] ?? HttpStatus.serverError,
      message: json['message'] ?? json['msg'] ?? '',
      data: fromJsonT != null && json['data'] != null 
          ? fromJsonT(json['data']) 
          : json['data'],
      success: json['success'] ?? (json['code'] == HttpStatus.success),
    );
  }
}

/// 自定义网络异常
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  NetworkException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

/// 网络服务 - 单例
class NetworkService extends GetxService {
  static NetworkService get instance => Get.find<NetworkService>();

  late Dio _dio;
  late EnvironmentConfig _envConfig;
  late CookieJar _cookieJar;
  // final CacheManager _cacheManager = CacheManager.instance;

  final RxBool isNetworkConnected = true.obs;

  // 基础配置
  final String _baseUrl = 'https://api.example.com'; // 替换为你的API地址
  final int _connectTimeout = 15000; // 15秒
  final int _receiveTimeout = 15000; // 15秒
  final int _sendTimeout = 10000; // 10秒 

  // 拦截器配置
  final bool _enableLogging = true;
  final bool _enableCache = false;
  final int _maxCacheAge = 300; // 5分钟

  @override
  Future<void> onInit() async {
    super.onInit();

    // 初始化Dio
    _initDio();
  }

  /// 初始化Dio
  void _initDio() {
    // 基础配置
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Accept-Language': Get.locale?.languageCode ?? 'en',
      },
    );

    _dio = Dio(options);
    _cookieJar = CookieJar();

    // 添加拦截器
    _addInterceptors();
  }

  /// 添加拦截器
  void _addInterceptors() {
    // Cookie管理
    _dio.interceptors.add(CookieManager(_cookieJar));

    // 日志拦截器
    if (_enableLogging) {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ));
    }

    // 认证拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 添加认证token
        final token = await _getAuthToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // 缓存逻辑
        // if (_enableCache && options.method == 'GET') {
        //   final cacheKey = _generateCacheKey(options);
        //   final cachedResponse = await _cacheManager.get<String>(cacheKey);
        //   if (cachedResponse != null) {
        //     final response = Response(
        //       requestOptions: options,
        //       data: json.decode(cachedResponse),
        //       statusCode: 200,
        //     );
        //     return handler.resolve(response);
        //   }
        // }

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // 缓存响应
        // if (_enableCache && 
        //     response.requestOptions.method == 'GET' && 
        //     response.statusCode == HttpStatus.success) {
        //   final cacheKey = _generateCacheKey(response.requestOptions);
        //   await _cacheManager.save(
        //     cacheKey, 
        //     json.encode(response.data),
        //     maxAge: _maxCacheAge,
        //   );
        // }
        return handler.next(response);
      },
      onError: (DioError error, handler) async {
        // 统一错误处理
        final errorMessage = await _handleError(error);
        return handler.reject(error);
      },
    ));
  }

  // /// 更新环境配置
  // void _updateDioForEnvironment(Environment env) async {
  //   final envManager = EnvironmentManager.instance;
  //   _envConfig = envManager.currentConfig;
    
  //   // 更新Dio配置
  //   _dio.options.baseUrl = _envConfig.baseUrl;
  //   _dio.options.headers['X-API-Key'] = _envConfig.apiKey;
  //   _dio.options.headers['X-Environment'] = _envConfig.name;
    
  //   // 清除缓存
  //   if (Get.isRegistered<CacheManager>()) {
  //     final cacheManager = Get.find<CacheManager>();
  //     // await cacheManager.clear();
  //   }
    
  //   // 清除Cookie（如果环境切换）
  //   await _cookieJar.deleteAll();
  // }

  /// 生成缓存key
  String _generateCacheKey(RequestOptions options) {
    final params = options.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    return '${options.path}?$params';
  }

  /// 获取认证token
  Future<String> _getAuthToken() async {
    // 从安全存储获取token
    // 这里需要根据你的具体实现来调整
    return '';
  }

  /// 处理错误
  Future<String> _handleError(DioError error) async {
    String errorMessage = 'network_error'.tr;

    if (error.type == DioErrorType.connectTimeout) {
      errorMessage = 'connection_timeout'.tr;
    } else if (error.type == DioErrorType.sendTimeout) {
      errorMessage = 'send_timeout'.tr;
    } else if (error.type == DioErrorType.receiveTimeout) {
      errorMessage = 'receive_timeout'.tr;
    } else if (error.type == DioErrorType.response) {
      switch (error.response?.statusCode) {
        case HttpStatus.badRequest:
          errorMessage = 'bad_request'.tr;
          break;
        case HttpStatus.unauthorized:
          errorMessage = 'unauthorized'.tr;
          // 可以在这里触发重新登录
          break;
        case HttpStatus.forbidden:
          errorMessage = 'forbidden'.tr;
          break;
        case HttpStatus.notFound:
          errorMessage = 'not_found'.tr;
          break;
        case HttpStatus.serverError:
          errorMessage = 'server_error'.tr;
          break;
        case HttpStatus.serviceUnavailable:
          errorMessage = 'service_unavailable'.tr;
          break;
        default:
          if (error.response?.data != null) {
            try {
              final response = error.response!.data;
              if (response is Map<String, dynamic>) {
                errorMessage = response['message'] ?? errorMessage;
              } else if (response is String) {
                errorMessage = response;
              }
            } catch (_) {}
          }
      }
    } else if (error.type == DioErrorType.cancel) {
      errorMessage = 'request_cancelled'.tr;
    }

    return errorMessage;
  }

  /// 基础请求方法
  Future<ApiResponse<T>> _request<T>({
    required String path,
    required HttpMethod method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
    bool withCache = false,
  }) async {
    try {
      final options = Options(headers: headers);
      DioResponse.Response response;

      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.put:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.delete:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case HttpMethod.patch:
          response = await _dio.patch(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }

      if (response.statusCode == HttpStatus.success ||
          response.statusCode == HttpStatus.created) {
        return ApiResponse<T>.fromJson(response.data, fromJsonT);
      } else {
        throw NetworkException(
          message: response.data['message'] ?? 'Unknown error',
          statusCode: response.statusCode,
          data: response.data,
        );
      }
    } on DioError catch (e) {
      final errorMessage = await _handleError(e);
      throw NetworkException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  // ============ 公开方法 ============

  /// 更新基础URL
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
    _envConfig = EnvironmentConfig(
      environment: _envConfig.environment,
      name: _envConfig.name,
      baseUrl: newBaseUrl,
      apiKey: _envConfig.apiKey,
      enableLogging: _envConfig.enableLogging,
      enableCache: _envConfig.enableCache,
      version: _envConfig.version,
    );
  }

  // ============ 公共API方法 ============

  /// GET请求
  Future<ApiResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
    bool withCache = false,
  }) async {
    return _request<T>(
      path: path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonT: fromJsonT,
      withCache: withCache,
    );
  }

  /// POST请求
  Future<ApiResponse<T>> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
  }) async {
    return _request<T>(
      path: path,
      method: HttpMethod.post,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonT: fromJsonT,
    );
  }

  /// PUT请求
  Future<ApiResponse<T>> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
  }) async {
    return _request<T>(
      path: path,
      method: HttpMethod.put,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonT: fromJsonT,
    );
  }

  /// DELETE请求
  Future<ApiResponse<T>> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
  }) async {
    return _request<T>(
      path: path,
      method: HttpMethod.delete,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonT: fromJsonT,
    );
  }

  /// PATCH请求
  Future<ApiResponse<T>> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic json)? fromJsonT,
  }) async {
    return _request<T>(
      path: path,
      method: HttpMethod.patch,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonT: fromJsonT,
    );
  }

  /// 上传文件
  // Future<ApiResponse<T>> upload<T>({
  //   required String path,
  //   required String filePath,
  //   String fieldName = 'file',
  //   Map<String, dynamic>? formData,
  //   Map<String, dynamic>? headers,
  //   T Function(dynamic json)? fromJsonT,
  // }) async {
  //   try {
  //     FormData form = FormData();
  //     form.files.add(MapEntry(
  //       fieldName,
  //       await MultipartFile.fromFile(filePath),
  //     ));

  //     if (formData != null) {
  //       formData.forEach((key, value) {
  //         form.fields.add(MapEntry(key, value.toString()));
  //       });
  //     }

  //     final response = await _dio.post(
  //       path,
  //       data: form,
  //       options: Options(headers: headers),
  //     );

  //     return ApiResponse<T>.fromJson(response.data, fromJsonT);
  //   } on DioError catch (e) {
  //     final errorMessage = await _handleError(e);
  //     throw NetworkException(
  //       message: errorMessage,
  //       statusCode: e.response?.statusCode,
  //       data: e.response?.data,
  //     );
  //   }
  // }

  /// 下载文件
  Future<void> download({
    required String url,
    required String savePath,
    void Function(int, int)? onProgress,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
      );
    } on DioError catch (e) {
      final errorMessage = await _handleError(e);
      throw NetworkException(message: errorMessage);
    }
  }

  /// 清除缓存
  // Future<void> clearCache() async {
  //   await _cacheManager.clear();
  // }

  /// 取消所有请求
  void cancelAllRequests() {
    _dio.close(force: true);
  }

  /// 获取当前Dio实例（供其他服务使用）
  Dio get dio => _dio;
}