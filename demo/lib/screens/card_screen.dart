import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _cur = 0;
  final _cards = [
    {'name': '生活卡', 'bal': '\$2,100', 'last4': '8842', 'dark': true, 'frozen': false},
    {'name': '差旅卡', 'bal': '\$1,400', 'last4': '3356', 'dark': false, 'frozen': false},
    {'name': '订阅卡', 'bal': '\$89.99', 'last4': '7721', 'dark': true, 'frozen': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: C.bg, surfaceTintColor: Colors.transparent, title: const Text('U卡'),
            actions: [TextButton(onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '新卡申请已提交')), child: const Text('申请新卡'))]),
          SliverToBoxAdapter(child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 210,
                child: PageView.builder(
                  itemCount: _cards.length,
                  controller: PageController(viewportFraction: 0.88),
                  onPageChanged: (i) => setState(() => _cur = i),
                  itemBuilder: (_, i) => _card(_cards[i], i == _cur),
                ),
              ),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_cards.length, (i) =>
                AnimatedContainer(duration: const Duration(milliseconds: 250), width: i == _cur ? 20 : 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(color: i == _cur ? C.black : C.grey300, borderRadius: BorderRadius.circular(3))))),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  QuickAction(icon: Icons.add_rounded, label: '充值', filled: true, onTap: () => showMockSuccess(context, '充值 \$500 成功')),
                  QuickAction(icon: Icons.ac_unit_rounded, label: _cards[_cur]['frozen'] as bool ? '解冻' : '冻结', onTap: () => setState(() => _cards[_cur]['frozen'] = !(_cards[_cur]['frozen'] as bool))),
                  QuickAction(icon: Icons.apple, label: 'Apple Pay', onTap: () => showMockSuccess(context, '已绑定 Apple Pay')),
                  QuickAction(icon: Icons.receipt_long_rounded, label: '报销单', onTap: () => showMockSuccess(context, '已生成3月报销单PDF\n共28笔 \$2,340')),
                ]),
              ),
              const SizedBox(height: 12),
              // Travel mode
              AppCard(
                onTap: () => showMockSuccess(context, '已启用旅行模式\n\n目的地：新加坡 3天\n建议预算：SGD 1,500'),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.flight_takeoff_rounded, color: C.brand, size: 20)),
                  const SizedBox(width: 14),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('旅行模式', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                    SizedBox(height: 2),
                    Text('AI 自动配置权限 · 预算 · 汇率提醒', style: TextStyle(fontSize: 13, color: C.grey500)),
                  ])),
                  const Icon(Icons.chevron_right_rounded, color: C.grey300),
                ]),
              ),
              Section(title: '消费记录', trailing: '全部', onTrailing: () {}),
              AppCard(padding: const EdgeInsets.symmetric(vertical: 4), child: Column(children: [
                _tx('Grab Food', '餐饮 · 曼谷', '-\$12.50', '今天 12:15'),
                _div(), _tx('7-Eleven', '购物', '-\$6.80', '今天 09:30'),
                _div(), _tx('BTS Skytrain', '交通', '-\$1.40', '昨天 18:20'),
                _div(), _tx('ChatGPT Plus', '订阅', '-\$20.00', '4月1日'),
              ])),
              const Section(title: '3月消费分析'),
              AppCard(child: Column(children: [
                _bar('餐饮', 0.35, '\$420'), _bar('购物', 0.28, '\$336'), _bar('交通', 0.15, '\$180'),
                _bar('订阅', 0.12, '\$144'), _bar('其他', 0.10, '\$120'),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1, color: C.grey200)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('总计', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    const Text('\$1,200', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    Text('返现 \$18.60', style: TextStyle(fontSize: 13, color: C.green, fontWeight: FontWeight.w500)),
                  ]),
                ]),
              ])),
              const SizedBox(height: 120),
            ],
          )),
        ],
      ),
    );
  }

  Widget _card(Map<String, dynamic> c, bool active) {
    final dark = c['dark'] as bool;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: active ? 0 : 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: dark ? C.black : C.brand,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(c['name'] as String, style: const TextStyle(color: Colors.white54, fontSize: 14, letterSpacing: 0.5)),
          if (c['frozen'] as bool)
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(8)),
              child: const Text('已冻结', style: TextStyle(color: Colors.white54, fontSize: 12)))
          else const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 3)),
        ]),
        const Spacer(),
        Text(c['bal'] as String, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -1)),
        const SizedBox(height: 10),
        Text('•••• •••• •••• ${c['last4']}', style: const TextStyle(color: Colors.white24, fontSize: 14, letterSpacing: 2)),
      ]),
    );
  }

  Widget _tx(String t, String s, String a, String d) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: const BoxDecoration(color: C.grey100, shape: BoxShape.circle),
        child: const Icon(Icons.receipt_rounded, color: C.grey700, size: 18)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -0.3)),
        Text(s, style: const TextStyle(fontSize: 13, color: C.grey500))])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(a, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(d, style: const TextStyle(fontSize: 12, color: C.grey300))]),
    ]),
  );

  Widget _div() => const Padding(padding: EdgeInsets.only(left: 74), child: Divider(height: 1, color: C.grey200));

  Widget _bar(String l, double r, String a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(children: [
      SizedBox(width: 36, child: Text(l, style: const TextStyle(fontSize: 14, color: C.grey500))),
      const SizedBox(width: 12),
      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(value: r, backgroundColor: C.grey200, color: C.black, minHeight: 6))),
      const SizedBox(width: 12),
      SizedBox(width: 48, child: Text(a, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
    ]),
  );
}
