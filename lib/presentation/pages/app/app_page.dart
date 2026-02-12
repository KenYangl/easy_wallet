import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_controller.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppState();
}

class _AppState extends State<AppPage> {
  final AppController _appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _appController.pages[_appController.selectedIndex];
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _appController.selectedIndex,
        onTap: (index) {
          setState(() {
            _appController.selectedIndex = index;
          });
        },
        items: _appController.navigationBars.map((item) => BottomNavigationBarItem(
          icon: item['icon']!,
          activeIcon: item['selectedIcon']!,
          label: item['label']!,
        )).toList(),
      ),
    );
  }
}