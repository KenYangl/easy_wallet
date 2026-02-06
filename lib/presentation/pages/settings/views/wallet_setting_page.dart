import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletSettingPage extends StatelessWidget {
  const WalletSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("wallet_setting".tr),
      ),
      body: const Center(
        child: Text('wallet setting'),
      ),
    );
  }
}