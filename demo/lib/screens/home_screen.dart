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
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 0,
            title: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF0A84FF), Color(0xFF5AC8FA)]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 10),
                const Text('SEA Wallet'),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.notifications_none_rounded), onPressed: () {}),
              IconButton(icon: const Icon(Icons.qr_code_scanner_rounded), onPressed: () {}),
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
        // AI Daily Brief
        _buildAiBrief(),
        const SizedBox(height: 12),
        // Balance Card
        _buildBalanceCard(context),
        const SizedBox(height: 12),
        // Quick Actions
        _buildQuickActions(context),
        const SizedBox(height: 4),
        // Assets
        SectionHeader(title: '资产', action: '全部', onAction: () {}),
        _buildAssetList(),
        // Transactions
        SectionHeader(title: '最近交易', action: '全部', onAction: () {}),
        _buildTransactionList(),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildAiBrief() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withValues(alpha: 0.08), AppColors.teal.withValues(alpha: 0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI 日报', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                SizedBox(height: 2),
                Text('昨日净流入\$2,100 · USDT/THB偏贵建议明天换汇', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('总资产 (USD)', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.earningGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('+\$47.30 今日', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.earningGreen)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('\$12,580.50', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -1)),
          const SizedBox(height: 4),
          const Text('≈ ₱706,016  |  ≈ ฿450,682  |  ≈ ¥91,083', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return InfoCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(icon: Icons.arrow_upward_rounded, label: '转账', color: AppColors.primary, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransferScreen()));
          }),
          ActionButton(icon: Icons.arrow_downward_rounded, label: '收款', color: AppColors.secondary, onTap: () {}),
          ActionButton(icon: Icons.swap_horiz_rounded, label: '换汇', color: AppColors.accent, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExchangeScreen()));
          }),
          ActionButton(icon: Icons.add_card_rounded, label: '入金', color: AppColors.purple, onTap: () {}),
          ActionButton(icon: Icons.qr_code_2_rounded, label: '扫码', color: AppColors.teal, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildAssetList() {
    return InfoCard(
      child: Column(
        children: MockData.assets.asMap().entries.map((entry) {
          final asset = entry.value;
          final isLast = entry.key == MockData.assets.length - 1;
          final isPositive = (asset['change'] as String).startsWith('+');
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: Color(asset['color'] as int).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text(asset['name'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(asset['color'] as int)))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(asset['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          Text(asset['balance'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(asset['value'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        Text(asset['change'] as String, style: TextStyle(fontSize: 12, color: isPositive ? AppColors.earningGreen : AppColors.danger)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 1, color: AppColors.divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionList() {
    return InfoCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: MockData.recentTransactions.map((tx) => TransactionTile(tx: tx)).toList(),
      ),
    );
  }
}
