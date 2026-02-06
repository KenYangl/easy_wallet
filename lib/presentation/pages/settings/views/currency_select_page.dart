import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/select_item.dart';
import '/core/utils/getx_extensions.dart';

class CurrencySelectPage extends StatelessWidget {
  // 当前选中的货币（可以从 GetX 控制器获取）
  final String currentCurrency = 'USD';

  const CurrencySelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.appColors.value.background,
      appBar: AppBar(
        backgroundColor: Get.appColors.value.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Get.appColors.value.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          '货币单位',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Get.appColors.value.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // USD
              SelectItem(
                title: 'USD',
                isSelected: currentCurrency == 'USD',
                onTap: () {
                  // 更新货币设置
                  Get.back();
                },
              ),
              // CNY
              SelectItem(
                title: 'CNY',
                isSelected: currentCurrency == 'CNY',
                onTap: () {
                  // 更新货币设置
                  Get.back();
                },
              ),
              // EUR
              SelectItem(
                title: 'EUR',
                isSelected: currentCurrency == 'EUR',
                onTap: () {
                  // 更新货币设置
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}