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
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Minimal top bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: AppColors.gradientBlue, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 17),
                ),
                const SizedBox(width: 10),
                const Text('SEA Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.notifications_none_rounded, size: 24), onPressed: () {}),
              const SizedBox(width: 4),
            ],
          ),
          SliverToBoxAdapter(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildBalanceHero(),
        const SizedBox(height: 24),
        _buildQuickActions(context),
        const SizedBox(height: 8),
        _buildAiBrief(),
        SectionHeader(title: '资产', action: '全部', onAction: () {}),
        _buildAssetList(),
        SectionHeader(title: '最近交易', action: '全部', onAction: () {}),
        _buildTransactionList(),
        const SizedBox(height: 120),
      ],
    );
  }

  // ──── Hero Balance Card ────
  Widget _buildBalanceHero() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('总资产', style: TextStyle(fontSize: 14, color: Colors.white54, letterSpacing: 0.5)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.earning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_rounded, color: AppColors.earning, size: 14),
                    SizedBox(width: 4),
                    Text('+\$47.30', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.earning)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('\$12,580.50', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -1.5)),
          const SizedBox(height: 8),
          const Text('≈ ₱706,016  ·  ≈ ฿450,682', style: TextStyle(fontSize: 13, color: Colors.white38, letterSpacing: 0.2)),
        ],
      ),
    );
  }

  // ──── Quick Actions (pill buttons with gradients) ────
  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PillAction(icon: Icons.north_rounded, label: '转账', gradient: AppColors.gradientBlue, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransferScreen()));
          }),
          PillAction(icon: Icons.south_rounded, label: '收款', gradient: AppColors.gradientGreen, onTap: () {}),
          PillAction(icon: Icons.swap_horiz_rounded, label: '换汇', gradient: AppColors.gradientOrange, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExchangeScreen()));
          }),
          PillAction(icon: Icons.add_rounded, label: '入金', gradient: AppColors.gradientPurple, onTap: () {
            showAuthSheet(context, onSuccess: () => showMockSuccess(context, '入金通道已开启'));
          }),
          PillAction(icon: Icons.qr_code_scanner_rounded, label: '扫码', gradient: const [Color(0xFF636366), Color(0xFF48484A)], onTap: () {}),
        ],
      ),
    );
  }

  // ──── AI Brief ────
  Widget _buildAiBrief() {
    return GlassCard(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.gradientBlue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI 日报', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: -0.2)),
                SizedBox(height: 3),
                Text('昨日净流入\$2,100 · USDT/THB 偏贵建议明天换汇', style: TextStyle(fontSize: 13, color: AppColors.textTertiary, letterSpacing: -0.1)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textQuaternary, size: 22),
        ],
      ),
    );
  }

  // ──── Asset List ────
  Widget _buildAssetList() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: MockData.assets.asMap().entries.map((entry) {
          final a = entry.value;
          final isLast = entry.key == MockData.assets.length - 1;
          final isUp = (a['change'] as String).startsWith('+');
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: Color(a['color'] as int).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: Text(a['name'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(a['color'] as int)))),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                          const SizedBox(height: 2),
                          Text(a['fullName'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(a['value'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                        const SizedBox(height: 2),
                        Text(a['change'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isUp ? AppColors.earning : AppColors.danger)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) const Padding(padding: EdgeInsets.only(left: 78), child: Divider(height: 1, color: AppColors.separatorLight)),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ──── Transaction List ────
  Widget _buildTransactionList() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: MockData.recentTransactions.asMap().entries.map((entry) {
          final isLast = entry.key == MockData.recentTransactions.length - 1;
          return Column(
            children: [
              TransactionTile(tx: entry.value),
              if (!isLast) const Padding(padding: EdgeInsets.only(left: 78), child: Divider(height: 1, color: AppColors.separatorLight)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
