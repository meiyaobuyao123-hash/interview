import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: C.bg, surfaceTintColor: Colors.transparent, title: const Text('赚钱')),
          SliverToBoxAdapter(child: Column(children: [
            const SizedBox(height: 8),
            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('理财总资产', style: TextStyle(fontSize: 13, color: C.grey500)),
              const SizedBox(height: 6),
              const Text('\$4,200.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.5)),
              const SizedBox(height: 4),
              const Text('≈ ₱236,166', style: TextStyle(fontSize: 13, color: C.grey300)),
              const SizedBox(height: 16),
              Row(children: [_stat('累计收益', '+\$128.50'), const SizedBox(width: 10), _stat('昨日收益', '+\$2.38')]),
            ])),
            const SizedBox(height: 12),
            AppCard(padding: const EdgeInsets.all(16), child: Row(children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.auto_awesome_rounded, color: C.brand, size: 18)),
              const SizedBox(width: 14),
              const Expanded(child: Text('\$8,500 闲置中，存入活期月赚约 \$42', style: TextStyle(fontSize: 14, color: C.grey500))),
              TextButton(onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '已存入 \$8,500')), child: const Text('存入')),
            ])),
            const Section(title: '稳定区'),
            ...MockData.earnProducts.where((p) => p['type'] == '稳定区').map((p) => _product(context, p)),
            const Section(title: '成长区'),
            ...MockData.earnProducts.where((p) => p['type'] == '成长区').map((p) => _product(context, p)),
            const Section(title: 'AI 储蓄目标'),
            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('6个月存 \$3,000', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(8)),
                  child: const Text('42%', style: TextStyle(fontSize: 13, color: C.brand, fontWeight: FontWeight.w600))),
              ]),
              const SizedBox(height: 16),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: const LinearProgressIndicator(value: 0.42, backgroundColor: C.grey200, color: C.brand, minHeight: 8)),
              const SizedBox(height: 10),
              const Text('已存 \$1,260 / \$3,000 · 预计8月达成', style: TextStyle(fontSize: 14, color: C.grey500)),
            ])),
            const SizedBox(height: 120),
          ])),
        ],
      ),
    );
  }

  Widget _product(BuildContext context, Map<String, dynamic> p) {
    final has = p['deposited'] != '\$0';
    return AppCard(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10), child: Row(children: [
      Container(width: 44, height: 44, decoration: const BoxDecoration(color: C.grey100, shape: BoxShape.circle),
        child: const Icon(Icons.show_chart_rounded, color: C.grey700, size: 20)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
        const SizedBox(height: 2),
        Text(has ? '已投 ${p['deposited']}' : '${p['minAmount']} 起投', style: const TextStyle(fontSize: 13, color: C.grey500)),
      ])),
      Text('${p['apy']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: C.brand)),
    ]));
  }

  Widget _stat(String l, String v) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(10)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: const TextStyle(fontSize: 12, color: C.grey500)),
      const SizedBox(height: 4),
      Text(v, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: C.green)),
    ]),
  ));
}
