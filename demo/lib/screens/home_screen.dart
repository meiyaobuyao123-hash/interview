import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';
import 'transfer_screen.dart';
import 'exchange_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: C.bg,
            surfaceTintColor: Colors.transparent,
            title: const Text('SEA Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
            actions: [
              IconButton(icon: const Icon(Icons.notifications_none_rounded, color: C.grey500, size: 22), onPressed: () {}),
              const SizedBox(width: 4),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _hero(),
                const SizedBox(height: 28),
                _actions(context),
                const SizedBox(height: 8),
                _aiBrief(),
                Section(title: '资产', trailing: '全部', onTrailing: () {}),
                _assets(),
                Section(title: '最近交易', trailing: '全部', onTrailing: () {}),
                _transactions(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('总资产', style: TextStyle(fontSize: 13, color: Colors.white38, letterSpacing: 0.5)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: C.green.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                child: const Text('+\$47.30 今日', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.green)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('\$12,580.50', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -2)),
          const SizedBox(height: 6),
          const Text('≈ ₱706,016  ·  ≈ ฿450,682', style: TextStyle(fontSize: 13, color: Colors.white24)),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickAction(icon: Icons.north_rounded, label: '转账', filled: true, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransferScreen()))),
          QuickAction(icon: Icons.south_rounded, label: '收款', onTap: () {}),
          QuickAction(icon: Icons.swap_horiz_rounded, label: '换汇', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExchangeScreen()))),
          QuickAction(icon: Icons.add_rounded, label: '入金', onTap: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '入金通道已开启'))),
          QuickAction(icon: Icons.qr_code_scanner_rounded, label: '扫码', onTap: () {}),
        ],
      ),
    );
  }

  Widget _aiBrief() {
    return AppCard(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: C.brandLight, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.auto_awesome_rounded, color: C.brand, size: 18),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI 日报', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text('昨日净流入\$2,100 · USDT/THB偏贵建议明天换汇', style: TextStyle(fontSize: 13, color: C.grey500)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: C.grey300, size: 20),
        ],
      ),
    );
  }

  Widget _assets() {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: MockData.assets.asMap().entries.map((e) {
          final a = e.value;
          final last = e.key == MockData.assets.length - 1;
          final up = (a['change'] as String).startsWith('+');
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    // Token icon - simple circle with letter
                    Container(
                      width: 40, height: 40,
                      decoration: const BoxDecoration(color: C.grey100, shape: BoxShape.circle),
                      child: Center(child: Text((a['name'] as String)[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: C.grey900))),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                          Text(a['fullName'] as String, style: const TextStyle(fontSize: 13, color: C.grey500)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(a['value'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                        Text(a['change'] as String, style: TextStyle(fontSize: 13, color: up ? C.green : C.red)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!last) const Padding(padding: EdgeInsets.only(left: 74), child: Divider(height: 1, color: C.grey200)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _transactions() {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: MockData.recentTransactions.asMap().entries.map((e) {
          final last = e.key == MockData.recentTransactions.length - 1;
          return Column(
            children: [
              TxTile(tx: e.value),
              if (!last) const Padding(padding: EdgeInsets.only(left: 78), child: Divider(height: 1, color: C.grey200)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
