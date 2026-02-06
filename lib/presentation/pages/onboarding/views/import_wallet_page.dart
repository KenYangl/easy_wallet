import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({super.key});

  @override
  State<ImportWalletPage> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  final TextEditingController _inputController = TextEditingController();
  final RxList<String> _mnemonicWords = <String>[].obs;
  final RxBool _isValid = false.obs;
  final RxBool _isMnemonic = true.obs;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _validateInput() {
    final input = _inputController.text.trim();
    if (input.isEmpty) {
      _isValid.value = false;
      _mnemonicWords.clear();
      return;
    }

    // 判断是助记词还是私钥
    if (input.contains(' ')) {
      _isMnemonic.value = true;
      _mnemonicWords.value = input.split(' ').where((word) => word.isNotEmpty).toList();
      // 校验助记词数量（12/15/18/21/24）
      _isValid.value = [12, 15, 18, 21, 24].contains(_mnemonicWords.length);
    } else {
      _isMnemonic.value = false;
      // 简单校验私钥格式（64位十六进制）
      _isValid.value = RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          '导入钱包',
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // 标题
              const Text(
                '输入助记词或私钥',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // 说明文字
              const Text(
                '支持通过12、24位助记词或私钥导入。输入助记词时，请用空格分隔每个单词。',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              // 输入框
              Obx(() {
                if (_isMnemonic.value && _mnemonicWords.isNotEmpty) {
                  // 助记词展示模式
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _mnemonicWords.asMap().entries.map((entry) {
                      final index = entry.key;
                      final word = entry.value;
                      return Chip(
                        label: Text('${index + 1}. $word'),
                        backgroundColor: Colors.grey.shade100,
                        labelStyle: const TextStyle(fontSize: 14),
                      );
                    }).toList(),
                  );
                } else {
                  // 普通输入模式
                  return TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: '输入助记词或私钥',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF80E8FF)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                  );
                }
              }),
              const Spacer(),
              // 导入按钮
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isValid.value
                        ? () {
                            // 执行导入逻辑
                            Get.offAllNamed('/home');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid.value ? const Color(0xFF80E8FF) : Colors.grey.shade300,
                      foregroundColor: _isValid.value ? Colors.black87 : Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '导入',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}