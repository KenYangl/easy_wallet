import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/getx_extensions.dart';

/// 通用 Token 列表项
class TokenItem extends StatelessWidget {
  // final String icon;
  final String name;
  final String symbol;
  final String price;
  final String change;
  final String balance;
  final bool isPositiveChange;

  const TokenItem({
    super.key,
    // required this.icon,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.balance,
    required this.isPositiveChange,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colors = Get.appColors.value;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            // Token 图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              // child: Image.asset(
              //   icon,
              //   fit: BoxFit.contain,
              // ),
            ),
            const SizedBox(width: 12),
            // Token 名称和价格
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$change%',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPositiveChange ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 余额
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  balance,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  '\$3.01',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}