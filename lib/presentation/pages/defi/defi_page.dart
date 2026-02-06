import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefiPage extends StatelessWidget {
  const DefiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeFi'),
      ),
      body: const Center(
        child: Text('DeFi Page'),
      ),
    );
  }
}