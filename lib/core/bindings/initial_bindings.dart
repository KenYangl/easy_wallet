import 'package:get/get.dart';
import '../../presentation/pages/onboarding/controllers/onboarding_controller.dart';
import '../services/network_service.dart';
import '/core/constants/storage_keys.dart';
import '/presentation/pages/app/app_controller.dart';

// 全局依赖绑定（启动时初始化控制器）
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // 懒加载Controllers
    Get.lazyPut(() => OnboardingController());

    Get.put(AppController(), permanent: true);

    // 注册网络服务
    Get.put(NetworkService(), permanent: true);
  }
}