import 'package:flutter/material.dart';

class NumberKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;
  final VoidCallback onDismiss;

  const NumberKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {}, // 阻止事件冒泡
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    // 快速选择金额
                    Row(
                      children: [
                        _buildQuickButton('25%'),
                        _buildQuickButton('50%'),
                        _buildQuickButton('75%'),
                        _buildQuickButton('最大'),
                      ],
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    // 数字键盘
                    Column(
                      children: [
                        _buildKeyboardRow(['1', '2', '3']),
                        _buildKeyboardRow(['4', '5', '6']),
                        _buildKeyboardRow(['7', '8', '9']),
                        _buildKeyboardRow(['.', '0', '⌫']),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickButton(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (key == '⌫') {
                onBackspace();
              } else {
                onKeyPressed(key);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                key,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}