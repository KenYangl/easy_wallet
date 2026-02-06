import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecuritySettingPage extends StatelessWidget {
  const SecuritySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("security_setting".tr),
      ),
      body: const Center(
        child: Text('security setting'),
      ),
    );
  }
}