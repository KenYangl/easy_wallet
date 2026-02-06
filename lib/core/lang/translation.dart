import 'package:get/get.dart';
import 'en.dart';
import 'zh.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh, // 简体中文
        'en_US': en, // 美式英语
      };
}