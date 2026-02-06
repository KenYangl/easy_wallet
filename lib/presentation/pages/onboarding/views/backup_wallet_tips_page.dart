import 'package:flutter/material.dart';

class BackupWalletTipsPage extends StatelessWidget {
  const BackupWalletTipsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('备份钱包提示'),
      ),
      body: const Center(
        child: Text('请备份您的钱包，以防止数据丢失'),
      ),
    );
  }
}