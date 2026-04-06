import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'merchant_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: C.bg, surfaceTintColor: Colors.transparent, title: const Text('我的')),
          SliverToBoxAdapter(child: Column(children: [
            const SizedBox(height: 8),
            AppCard(child: Row(children: [
              Container(width: 52, height: 52, decoration: BoxDecoration(color: C.black, borderRadius: BorderRadius.circular(14)),
                child: const Center(child: Text('E', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: C.white)))),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Eathon', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3)),
                const SizedBox(height: 4),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: C.green.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
                  child: const Text('KYC 已认证', style: TextStyle(fontSize: 12, color: C.green, fontWeight: FontWeight.w600))),
              ])),
              const Icon(Icons.chevron_right_rounded, color: C.grey300),
            ])),
            const SizedBox(height: 12),
            AppCard(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MerchantScreen())),
              child: Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: C.brand, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.storefront_rounded, color: C.white, size: 20)),
                const SizedBox(width: 14),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('商户模式', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text('收款 · 对账 · 发薪 · 报表', style: TextStyle(fontSize: 13, color: C.grey500)),
                ])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: C.brand, borderRadius: BorderRadius.circular(8)),
                  child: const Text('进入', style: TextStyle(fontSize: 13, color: C.white, fontWeight: FontWeight.w600))),
              ]),
            ),
            const SizedBox(height: 20),
            _group([_item(Icons.language_rounded, '语言', '简体中文'), _item(Icons.attach_money_rounded, '基准货币', 'USD'), _item(Icons.notifications_none_rounded, '通知', '')]),
            const SizedBox(height: 12),
            _group([_item(Icons.shield_outlined, '安全设置', ''), _item(Icons.fingerprint_rounded, 'Face ID', '已开启'), _item(Icons.key_rounded, 'MPC 密钥', '已备份')]),
            const SizedBox(height: 12),
            _group([_item(Icons.gavel_rounded, 'AI 合规助手', '6国'), _item(Icons.chat_bubble_outline_rounded, 'AI 对话', ''), _item(Icons.support_agent_rounded, '人工客服', '24h')]),
            const SizedBox(height: 120),
          ])),
        ],
      ),
    );
  }

  Widget _group(List<Widget> items) => AppCard(padding: EdgeInsets.zero, child: Column(
    children: items.asMap().entries.map((e) => Column(children: [
      e.value,
      if (e.key < items.length - 1) const Padding(padding: EdgeInsets.only(left: 60), child: Divider(height: 1, color: C.grey200)),
    ])).toList(),
  ));

  Widget _item(IconData icon, String t, String v) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Row(children: [
      Container(width: 28, height: 28, decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(7)),
        child: Icon(icon, color: C.grey700, size: 16)),
      const SizedBox(width: 14),
      Expanded(child: Text(t, style: const TextStyle(fontSize: 16))),
      if (v.isNotEmpty) Text(v, style: const TextStyle(fontSize: 15, color: C.grey500)),
      const SizedBox(width: 4),
      const Icon(Icons.chevron_right_rounded, color: C.grey300, size: 18),
    ]),
  );
}
