import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(title: const Text('换汇中心'), backgroundColor: C.bg),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: 8),
          AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('USDT → THB', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: C.orange.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                child: const Text('78% 偏贵', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: C.orange))),
            ]),
            const SizedBox(height: 20),
            const Center(child: Text('35.82', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -2))),
            const SizedBox(height: 20),
            // Simple percentile bar
            ClipRRect(borderRadius: BorderRadius.circular(4), child: const LinearProgressIndicator(value: 0.78, backgroundColor: C.grey200, color: C.black, minHeight: 6)),
            const SizedBox(height: 8),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('便宜', style: TextStyle(fontSize: 11, color: C.grey500)),
              Text('贵', style: TextStyle(fontSize: 11, color: C.grey500)),
            ]),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(10)),
              child: const Text('当前汇率偏高，如不急可等1-2天。5天前最低点：35.41', style: TextStyle(fontSize: 13, color: C.grey500, height: 1.5))),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: SizedBox(height: 50, child: ElevatedButton(
                onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '换汇成功！\n500 USDT → ฿17,910')),
                style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('立即换汇', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))))),
              const SizedBox(width: 10),
              Expanded(child: SizedBox(height: 50, child: OutlinedButton(
                onPressed: () => showMockSuccess(context, '已设置目标价提醒\nUSDT/THB ≤ 35.40 时通知'),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: C.grey200), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('目标价', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.grey900))))),
            ]),
          ])),
          Section(title: '全部汇率', trailing: '', onTrailing: () {}),
          AppCard(padding: const EdgeInsets.symmetric(vertical: 8), child: Column(
            children: MockData.fxRates.asMap().entries.map((e) {
              final r = e.value; final last = e.key == MockData.fxRates.length - 1;
              final p = r['percentile'] as int;
              return Column(children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                  Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(r['pair'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                    Text(r['trend'] as String, style: TextStyle(fontSize: 13, color: (r['trend'] as String).startsWith('+') ? C.red : C.green)),
                  ])),
                  Expanded(flex: 2, child: Text(r['rate'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(6)),
                    child: Text('$p%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.grey700))),
                ])),
                if (!last) const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(height: 1, color: C.grey200)),
              ]);
            }).toList(),
          )),
          const SizedBox(height: 120),
        ]),
      ),
    );
  }
}
