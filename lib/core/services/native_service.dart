import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';

abstract class _PlatformService {
  /// 创建钱包
  Future<String> createWallet();
  /// 恢复钱包
  Future <String> restoreWallet(String mnemonic);
}

class NativeService implements _PlatformService {

  // 单例模式
  static final NativeService _instance = NativeService._internal();
  factory NativeService() => _instance;
  NativeService._internal();

  @override
  Future<String> createWallet() async {
    if (GetPlatform.isIOS) {
      return await _IosPlatformService().createWallet();
    } else if (GetPlatform.isAndroid) {
      return await _AndroidPlatformService().createWallet();
    }
    throw UnimplementedError("当前平台不支持");
  }

  @override
  Future <String> restoreWallet(String mnemonic) async {
    if (GetPlatform.isIOS) {
      return await _IosPlatformService().restoreWallet(mnemonic);
    } else if (GetPlatform.isAndroid) {
      return await _AndroidPlatformService().restoreWallet(mnemonic);
    }
    throw UnimplementedError("当前平台不支持");
  }
}

class _IosPlatformService implements _PlatformService {
  // 单例模式
  static final _IosPlatformService _instance = _IosPlatformService._internal();
  factory _IosPlatformService() => _instance;
  _IosPlatformService._internal();

  static const platform = MethodChannel('com.wallet.core/native');

  @override
  Future<String> createWallet() async {
    try {
      final String result = await platform.invokeMethod('createWallet');
      print('createWallet: $result');
      return result;
    } on PlatformException catch (e) {
      throw Exception("调用失败: '${e.message}'");
    }
  }

  @override
  Future <String> restoreWallet(String mnemonic) async {
    try {
      final String result = await platform.invokeMethod('restoreWallet', mnemonic);
      print('restoreWallet: $result');
      return result;
    } on PlatformException catch (e) {
      throw Exception("调用失败: '${e.message}'");
    }
  }
}

class _AndroidPlatformService implements _PlatformService {
  // 单例模式
  static final _AndroidPlatformService _instance = _AndroidPlatformService._internal();
  factory _AndroidPlatformService() => _instance;
  _AndroidPlatformService._internal();

  static const platform = MethodChannel('com.wallet.core/native');

  @override
  Future<String> createWallet() async {
    try {
      final String result = await platform.invokeMethod('createWallet');
      return result;
    } on PlatformException catch (e) {
      throw Exception("调用失败: '${e.message}'");
    }
  }

  @override
  Future <String> restoreWallet(String mnemonic) async {
    try {
      final String result = await platform.invokeMethod('restoreWallet', mnemonic);
      return result;
    } on PlatformException catch (e) {
      throw Exception("调用失败: '${e.message}'");
    }
  }
}