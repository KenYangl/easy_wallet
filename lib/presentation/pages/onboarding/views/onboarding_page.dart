import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/presentation/pages/onboarding/controllers/onboarding_controller.dart';
import '/presentation/widgets/action_buttons/primary_button.dart';
import '/presentation/widgets/action_buttons/secondary_button.dart';
import '/presentation/pages/onboarding/widgets/onboarding_carousel.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
          child: SizedBox(
            width: double.infinity,
            // 最小高度 = 屏幕高度 - SafeArea 上下边距
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              // 轮播组件
              const SizedBox(
                height: 400.0,
                child: OnboardingCarousel(),
              ),

              const SizedBox(height: 40),

              // 创建钱包按钮
              PrimaryButton(
                text: 'onboarding_create'.tr,
                onPressed: () {
                  controller.navigateToCreateWallet();
                }
              ),

              const SizedBox(height: 16.0),

              // 导入钱包按钮
              SecondaryButton(text: 'onboarding_import'.tr, 
              onPressed: () {
                controller.navigateToImportWallet();
              }),

              const SizedBox(height: 16.0)
            ],
          ),
        ),
      ),
    ));
  }
}