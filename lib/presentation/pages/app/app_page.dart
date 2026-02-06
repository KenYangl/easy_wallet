import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_controller.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  State<AppPage> createState() => _AppState();
}

class _AppState extends State<AppPage> {
  final AppController _appController = Get.find<AppController>();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void setIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _appController.pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: setIndex,
        items: _appController.navigationBars.map((item) => BottomNavigationBarItem(
          icon: item['icon']!,
          activeIcon: item['selectedIcon']!,
          label: item['label']!,
        )).toList(),
      ),
    );
  }
}