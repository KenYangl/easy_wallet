import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'onboarding_card.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  // 当前轮播索引
  final RxInt _currentIndex = 0.obs;
  // 轮播控制器
  final CarouselController _carouselController = CarouselController();

  // 引导页数据配置
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboarding_image1.png',
      'title': 'onboarding_title1'.tr,
    },
    {
      'image': 'assets/images/onboarding_image2.png',
      'title': 'onboarding_title2'.tr,
    },
    {
      'image': 'assets/images/onboarding_image3.png',
      'title': 'onboarding_title3'.tr,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 轮播区域
              Expanded(
                child: CarouselSlider(
                  items: _onboardingData.map((item) {
                    return OnboardingCard(
                      imagePath: item['image']!,
                      title: item['title']!,
                    );
                  }).toList(),
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0, // 全屏显示
                    enableInfiniteScroll: true, // 开启无限循环
                    onPageChanged: (index, reason) {
                      _currentIndex.value = index;
                    },
                  ),
                ),
              ),

              // 指示器
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _onboardingData.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex.value == entry.key
                              ? const Color(0xFF80E8FF)
                              : Colors.grey.shade300,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}