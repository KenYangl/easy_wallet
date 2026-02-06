import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '/presentation/pages/swap/controllers/swap_controller.dart';

class SwapPage extends StatelessWidget {
  SwapPage({super.key}) {
    // 初始化Controller
    Get.put(SwapController());
  }

  @override
  Widget build(BuildContext context) {
    final SwapController controller = Get.find<SwapController>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('闪兑'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // 转出货币输入卡片
            _buildCurrencyInputCard(
              controller: controller,
              title: '从',
              currency: 'USDT',
              isFrom: true,
            ),
            const SizedBox(height: 16),
            // 转入货币显示卡片
            _buildCurrencyInputCard(
              controller: controller,
              title: '到',
              currency: 'TRX',
              isFrom: false,
            ),
            const SizedBox(height: 24),
            // 兑换按钮
            _buildSwapButton(controller),
            const SizedBox(height: 16),
            // 快速选择金额
            _buildQuickAmountSelector(controller),
            const SizedBox(height: 20),
            // 详情区域（初始隐藏）
            _buildDetailsSection(controller),
          ],
        ),
      ),
    );
  }

  // 货币输入/显示卡片
  Widget _buildCurrencyInputCard({
    required SwapController controller,
    required String title,
    required String currency,
    required bool isFrom,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题和可用余额
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600])),
              if (isFrom)
                Text(
                  '可用: ${controller.availableBalance} $currency',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // 货币选择和金额输入/显示
          Row(
            children: [
              // 货币图标+名称
              Row(
                children: [
                  // 替换为实际的货币图标
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: currency == 'USDT' ? Colors.blue[100] : Colors.black12,
                    ),
                    child: Center(
                      child: Text(
                        currency.substring(0, 1),
                        style: TextStyle(
                          color: currency == 'USDT' ? Colors.blue : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(currency, style: const TextStyle(fontWeight: FontWeight.w500)),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
              const Spacer(),
              // 金额输入/显示
              if (isFrom)
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: controller.fromAmountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,6}$'))
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '0.00',
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                )
              else
                StreamBuilder<double>(
                  stream: controller.fromAmountStream,
                  builder: (context, snapshot) {
                    final amount = snapshot.data ?? 0.0;
                    final targetAmount = controller.calculateTargetAmount(amount);
                    return Text(
                      amount > 0 ? targetAmount.toStringAsFixed(2) : '0.00',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    );
                  },
                ),
            ],
          ),
          // 最小金额提示（仅输入金额不足时显示）
          StreamBuilder<bool>(
            stream: controller.isAmountTooSmallStream,
            builder: (context, snapshot) {
              final isTooSmall = snapshot.data ?? false;
              if (isTooSmall) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '最小兑换数量: ${controller.minRequiredAmount} $currency',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  // 兑换按钮
  Widget _buildSwapButton(SwapController controller) {
    return StreamBuilder<bool>(
      stream: controller.isAmountValidStream,
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? false;
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isEnabled ? controller.performSwap : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? Colors.blue : Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              '确认兑换',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }

  // 快速选择金额
  Widget _buildQuickAmountSelector(SwapController controller) {
    final List<double> percentages = [25, 50, 75, 100];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: percentages.map((percentage) {
        return GestureDetector(
          onTap: () => controller.selectQuickAmount(percentage),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${percentage}%',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // 详情区域（汇率、滑点等）
  Widget _buildDetailsSection(SwapController controller) {
    return StreamBuilder<bool>(
      stream: controller.showDetailsStream,
      builder: (context, snapshot) {
        final showDetails = snapshot.data ?? false;
        if (!showDetails) return const SizedBox.shrink();

        return StreamBuilder<double>(
          stream: controller.fromAmountStream,
          builder: (context, snapshot) {
            final amount = snapshot.data ?? 0.0;
            final targetAmount = controller.calculateTargetAmount(amount);
            
            return Column(
              children: [
                // 汇率
                _buildDetailItem('汇率', '1 USDT = ${controller.exchangeRate} TRX'),
                // 滑点
                _buildDetailItem('滑动', '${controller.slippage}%'),
                // 最低接受数量
                _buildDetailItem('最低接受数量', '${controller.minAcceptAmount} TRX'),
                // 网络费用
                _buildDetailItem('网络费用', '${controller.networkFee} TRX'),
                // 提供者
                _buildDetailItem('提供者', controller.provider),
                // 预计收到
                _buildDetailItem('预计收到', '≈ ${targetAmount.toStringAsFixed(6)} TRX'),
              ],
            );
          },
        );
      },
    );
  }

  // 详情项通用组件
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}