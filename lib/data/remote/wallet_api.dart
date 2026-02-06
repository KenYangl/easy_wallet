import '/core/services/network_service.dart';
import '/data/models/wallet_model.dart';
import '/data/models/wallet_balance.dart';
import 'api_client.dart';

/// 钱包相关API
class WalletApi extends ApiClient {
  static final WalletApi _instance = WalletApi._internal();
  factory WalletApi() => _instance;
  WalletApi._internal();

  /// 获取钱包余额
  // Future<ApiResponse<List<WalletBalance>>> getWalletBalances({
  //   required String address,
  //   String chain = 'ethereum',
  // }) async {
  //   return get<List<WalletBalance>>(
  //     '/wallet/balance',
  //     queryParams: {
  //       'address': address,
  //       'chain': chain,
  //     },
  //     fromJson: (json) {
  //       if (json is List) {
  //         return json.map((item) => WalletBalance.fromJson(item)).toList();
  //       }
  //       return [];
  //     },
  //   );
  // }

  /// 获取交易记录
  // Future<ApiResponse<List<Transaction>>> getTransactions({
  //   required String address,
  //   int page = 1,
  //   int limit = 20,
  // }) async {
  //   return get<List<Transaction>>(
  //     '/wallet/transactions',
  //     queryParams: {
  //       'address': address,
  //       'page': page,
  //       'limit': limit,
  //     },
  //     fromJson: (json) {
  //       if (json is List) {
  //         return json.map((item) => Transaction.fromJson(item)).toList();
  //       }
  //       return [];
  //     },
  //   );
  // }

  /// 获取当前币价
  Future<ApiResponse<Map<String, double>>> getTokenPrices({
    required List<String> tokenIds,
  }) async {
    return get<Map<String, double>>(
      '/tokens/prices',
      queryParams: {
        'ids': tokenIds.join(','),
      },
      fromJson: (json) {
        if (json is Map<String, dynamic>) {
          return json.map((key, value) => MapEntry(key, value.toDouble()));
        }
        return {};
      },
    );
  }
}