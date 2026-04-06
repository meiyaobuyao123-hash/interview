import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class MerchantScreen extends StatelessWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = MockData.aiDailyReport;
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: C.bg, surfaceTintColor: Colors.transparent, title: const Text('商户工具'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('返回个人', style: TextStyle(fontSize: 14)))]),
          SliverToBoxAdapter(child: Column(children: [
            const SizedBox(height: 8),
            // AI report
            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 32, height: 32, decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.auto_awesome_rounded, color: C.brand, size: 16)),
                const SizedBox(width: 12),
                Text('AI 日报 · ${r['date']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 16),
              Row(children: [_stat('收款', r['totalReceived'] as String, C.green), const SizedBox(width: 8),
                _stat('支出', r['totalSpent'] as String, C.red), const SizedBox(width: 8),
                _stat('净流入', r['netInflow'] as String, C.brand)]),
              const SizedBox(height: 12),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(10)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r['suggestion'] as String, style: const TextStyle(fontSize: 13, color: C.grey500, height: 1.5)),
                  const SizedBox(height: 4),
                  Text(r['earningSuggestion'] as String, style: const TextStyle(fontSize: 13, color: C.green, height: 1.5)),
                ])),
            ])),
            const SizedBox(height: 16),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              QuickAction(icon: Icons.qr_code_2_rounded, label: '收款码', filled: true, onTap: () => _showQR(context)),
              QuickAction(icon: Icons.camera_alt_rounded, label: 'AI对账', onTap: () => showMockSuccess(context, '已识别微信账单3笔\n差异: ¥0')),
              QuickAction(icon: Icons.groups_rounded, label: '发薪', onTap: () => _showPayroll(context)),
              QuickAction(icon: Icons.description_rounded, label: '月报', onTap: () => showMockSuccess(context, '已生成3月财务报表\n利润 \$6,200')),
            ])),
            Section(title: '今日流水', trailing: '全部', onTrailing: () {}),
            AppCard(padding: const EdgeInsets.symmetric(vertical: 4), child: Column(
              children: MockData.merchantTransactions.asMap().entries.map((e) {
                final tx = e.value; final last = e.key == MockData.merchantTransactions.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Container(width: 40, height: 40, decoration: const BoxDecoration(color: C.grey100, shape: BoxShape.circle),
                      child: const Icon(Icons.south_rounded, color: C.green, size: 18)),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(tx['customer'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('${tx['type']} · ${tx['currency']}', style: const TextStyle(fontSize: 13, color: C.grey500)),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('+${tx['amount']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.green)),
                      Text(tx['time'] as String, style: const TextStyle(fontSize: 12, color: C.grey300)),
                    ]),
                  ])),
                  if (!last) const Padding(padding: EdgeInsets.only(left: 74), child: Divider(height: 1, color: C.grey200)),
                ]);
              }).toList(),
            )),
            Section(title: '员工管理', trailing: '批量发薪', onTrailing: () => _showPayroll(context)),
            AppCard(padding: const EdgeInsets.symmetric(vertical: 4), child: Column(
              children: MockData.employees.asMap().entries.map((e) {
                final emp = e.value; final last = e.key == MockData.employees.length - 1; final paid = emp['status'] == '已发放';
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Container(width: 36, height: 36, decoration: const BoxDecoration(color: C.grey100, shape: BoxShape.circle),
                      child: Center(child: Text((emp['name'] as String)[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)))),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(emp['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(emp['role'] as String, style: const TextStyle(fontSize: 13, color: C.grey500)),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(emp['salary'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(emp['status'] as String, style: TextStyle(fontSize: 12, color: paid ? C.green : C.orange)),
                    ]),
                  ])),
                  if (!last) const Padding(padding: EdgeInsets.only(left: 70), child: Divider(height: 1, color: C.grey200)),
                ]);
              }).toList(),
            )),
            const SizedBox(height: 120),
          ])),
        ],
      ),
    );
  }

  Widget _stat(String l, String v, Color c) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Text(l, style: const TextStyle(fontSize: 12, color: C.grey500)),
      const SizedBox(height: 4),
      Text(v, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c)),
    ]),
  ));

  void _showQR(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => BackdropFilter(filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
          decoration: const BoxDecoration(color: C.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: C.grey300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 28),
            const Text('金龙餐厅', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('USDT / THB 双币种收款', style: TextStyle(fontSize: 14, color: C.grey500)),
            const SizedBox(height: 28),
            Container(width: 180, height: 180, decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.qr_code_2_rounded, size: 140)),
            const SizedBox(height: 28),
            Row(children: [
              Expanded(child: SizedBox(height: 50, child: OutlinedButton(onPressed: () => Navigator.pop(ctx), style: OutlinedButton.styleFrom(side: const BorderSide(color: C.grey200), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('保存', style: TextStyle(color: C.grey900))))),
              const SizedBox(width: 10),
              Expanded(child: SizedBox(height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('打印')))),
            ]),
          ]),
        ),
      ),
    );
  }

  void _showPayroll(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => BackdropFilter(filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          decoration: const BoxDecoration(color: C.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: C.grey300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Text('批量发薪', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('需要双签审批', style: TextStyle(fontSize: 14, color: C.grey500)),
            const SizedBox(height: 24),
            _payRow('Nguyen Thi', '清洁', '₫5,000,000'),
            _payRow('Lin Wei', '收银', '฿10,000'),
            const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: C.grey200)),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('总计', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Text('\$480', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
              onPressed: () { Navigator.pop(ctx); showMockSuccess(context, '发薪审批已发起\n等待财务双签确认'); },
              style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: const Text('发起审批', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)))),
          ]),
        ),
      ),
    );
  }

  Widget _payRow(String n, String r, String a) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(n, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      Text(r, style: const TextStyle(fontSize: 13, color: C.grey500)),
    ])),
    Text(a, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  ]));
}
