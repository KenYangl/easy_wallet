// 缓存管理
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  final Map<String, dynamic> _memoryCache = {};
  // final SharedPreferences _prefs;
  
  Future<void> cacheTokenPrices(Map<String, double> prices) async {
    _memoryCache['token_prices'] = prices;
    // await _prefs.setString('token_prices', json.encode(prices));
  }
}