import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/constants/app_colors.dart';
import '/core/utils/getx_extensions.dart';

class SwapPage extends StatelessWidget {
  const SwapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap'),
        backgroundColor: colors.brandPrimary,
      ),
      body: const Center(
        child: Text('Swap Page'),
      ),
    );
  }
}
