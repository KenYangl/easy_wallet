import 'package:flutter/material.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发送'),
      ),
      body: const Center(
        child: Text('发送页面'),
      ),
    );
  }
}
