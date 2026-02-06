import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SwapController extends GetxController {
  // 输入金额控制器
  final TextEditingController fromAmountController = TextEditingController();
  
  // RxDart 响应式数据流
  final rxdart.BehaviorSubject<double> _fromAmount$ = rxdart.BehaviorSubject.seeded(0.0);
  final rxdart.BehaviorSubject<bool> _isAmountValid$ = rxdart.BehaviorSubject.seeded(false);
  final rxdart.BehaviorSubject<bool> _isAmountTooSmall$ = rxdart.BehaviorSubject.seeded(false);
  
  // 只读流（外部只可监听，不可修改）
  Stream<double> get fromAmountStream => _fromAmount$.stream;
  Stream<bool> get isAmountValidStream => _isAmountValid$.stream;
  Stream<bool> get isAmountTooSmallStream => _isAmountTooSmall$.stream;
  
  // 合并流：是否显示详情区域
  Stream<bool> get showDetailsStream => rxdart.Rx.combineLatest2(
    _isAmountValid$,
    _isAmountTooSmall$,
    (valid, tooSmall) => valid || tooSmall,
  );

  // 常量配置
  final double exchangeRate = 0.76341323;    // 汇率
  final double slippage = 1.0;               // 滑点
  final double minAcceptAmount = 0.70213341; // 最低接受数量
  final double networkFee = 0.70313341;      // 网络费用
  final String provider = 'Sun.io';          // 提供者
  final double minRequiredAmount = 10.0;     // 最小兑换金额
  final double availableBalance = 332.09;    // 可用余额

  @override
  void onInit() {
    super.onInit();
    // 监听输入框变化，转换为响应式数据流
    fromAmountController.addListener(_onAmountChanged);
  }

  @override
  void onClose() {
    fromAmountController.dispose();
    _fromAmount$.close();
    _isAmountValid$.close();
    _isAmountTooSmall$.close();
    super.onClose();
  }

  // 金额变化处理
  void _onAmountChanged() {
    final String input = fromAmountController.text.trim();
    double amount = 0.0;
    
    if (input.isNotEmpty) {
      amount = double.tryParse(input) ?? 0.0;
    }
    
    // 更新数据流
    _fromAmount$.add(amount);
    _isAmountTooSmall$.add(amount > 0 && amount < minRequiredAmount);
    _isAmountValid$.add(amount >= minRequiredAmount);
  }

  // 快速选择金额（25%/50%/75%/100%）
  void selectQuickAmount(double percentage) {
    final double amount = availableBalance * percentage / 100;
    fromAmountController.text = amount.toStringAsFixed(2);
  }

  // 计算目标货币金额
  double calculateTargetAmount(double fromAmount) {
    return fromAmount / exchangeRate;
  }

  // 执行兑换操作
  void performSwap() {
  }
}