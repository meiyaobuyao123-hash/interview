import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int _mode = 0;
  final _amt = TextEditingController(text: '500');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(title: const Text('转账'), backgroundColor: C.bg),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: C.grey200, borderRadius: BorderRadius.circular(10)),
            child: Row(children: [_tab('跨境汇款', 0), _tab('本地转账', 1), _tab('链上转账', 2)]),
          ),
          if (_mode == 0) _remit(),
          if (_mode == 1) _local(),
          if (_mode == 2) _chain(),
        ]),
      ),
    );
  }

  Widget _tab(String l, int i) {
    final on = _mode == i;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _mode = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(color: on ? C.white : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: on ? FontWeight.w600 : FontWeight.w400, color: on ? C.black : C.grey500)),
      ),
    ));
  }

  Widget _remit() => Column(children: [
    AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('汇款金额', style: TextStyle(fontSize: 13, color: C.grey500)),
      const SizedBox(height: 8),
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        const Text('\$', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: C.grey300)),
        const SizedBox(width: 4),
        Expanded(child: TextField(controller: _amt, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w700, letterSpacing: -1),
          keyboardType: TextInputType.number, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(8)),
          child: const Text('USDT', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: C.brand))),
      ]),
      const SizedBox(height: 6),
      const Text('余额 \$8,200  ·  ≈ ₱28,115', style: TextStyle(fontSize: 13, color: C.grey300)),
    ])),
    const SizedBox(height: 10),
    AppCard(padding: const EdgeInsets.all(14), child: Row(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: C.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.auto_awesome_rounded, color: C.green, size: 16)),
      const SizedBox(width: 12),
      const Expanded(child: Text('30天78分位，比昨天好0.3%，建议现在汇', style: TextStyle(fontSize: 13, color: C.grey500))),
    ])),
    const SizedBox(height: 10),
    AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('收款人', style: TextStyle(fontSize: 13, color: C.grey500)),
      const SizedBox(height: 12),
      _row('姓名', '张伟'), _row('收款方式', 'GCash · +63 917****1234'), _row('到账币种', 'PHP'),
    ])),
    const SizedBox(height: 10),
    AppCard(child: Column(children: [
      _row('手续费', '\$1.50 (0.3%)'), _row('汇率', '1 USDT = 56.23 PHP'),
      const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1, color: C.grey200)),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('收款人收到', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const Text('₱28,045', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 10),
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: C.green.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [Icon(Icons.savings_rounded, color: C.green, size: 16), const SizedBox(width: 8),
          Text('比 Western Union 省 ₱1,180', style: TextStyle(fontSize: 14, color: C.green, fontWeight: FontWeight.w500))])),
    ])),
    const SizedBox(height: 28),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: SizedBox(width: double.infinity, height: 54,
      child: ElevatedButton(
        onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '汇款成功！\n₱28,045 将在30分钟内到账')),
        style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: const Text('确认汇款', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))))),
    const SizedBox(height: 60),
  ]);

  Widget _local() => AppCard(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(32), child: Column(children: [
    Container(width: 56, height: 56, decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.phone_android_rounded, color: C.brand, size: 28)),
    const SizedBox(height: 20),
    const Text('输入手机号即可转账', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    const SizedBox(height: 6),
    const Text('对方无需注册，直接到账本地货币', style: TextStyle(fontSize: 14, color: C.grey500)),
    const SizedBox(height: 24),
    TextField(decoration: InputDecoration(hintText: '输入手机号', hintStyle: const TextStyle(color: C.grey300), prefixIcon: const Icon(Icons.search_rounded, color: C.grey300),
      filled: true, fillColor: C.grey100, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
  ]));

  Widget _chain() => AppCard(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(32), child: Column(children: [
    Container(width: 56, height: 56, decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.link_rounded, color: C.grey700, size: 28)),
    const SizedBox(height: 20),
    const Text('链上转账', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    const SizedBox(height: 6),
    const Text('Tron / BSC / Ethereum', style: TextStyle(fontSize: 14, color: C.grey500)),
    const SizedBox(height: 24),
    TextField(decoration: InputDecoration(hintText: '粘贴钱包地址', hintStyle: const TextStyle(color: C.grey300), suffixIcon: const Icon(Icons.qr_code_scanner_rounded, color: C.grey500),
      filled: true, fillColor: C.grey100, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
  ]));

  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 7), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(l, style: const TextStyle(fontSize: 15, color: C.grey500)), Text(v, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))]));
}
