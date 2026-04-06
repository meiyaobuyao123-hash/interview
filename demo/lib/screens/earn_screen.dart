import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: AppColors.background, surfaceTintColor: Colors.transparent, title: const Text('赚钱')),
          SliverToBoxAdapter(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Summary
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('理财总资产', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 8),
              const Text('\$4,200.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1)),
              const SizedBox(height: 4),
              const Text('≈ ₱236,166', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _stat('累计收益', '+\$128.50', AppColors.earning),
                  const SizedBox(width: 12),
                  _stat('昨日收益', '+\$2.38', AppColors.earning),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // AI tip
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientGreen), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              const Expanded(child: Text('\$8,500 闲置中，存入活期月赚约 \$42', style: TextStyle(fontSize: 14, color: AppColors.textSecondary))),
              TextButton(
                onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '已存入 \$8,500 到 USDT活期')),
                child: const Text('存入'),
              ),
            ],
          ),
        ),

        const SectionHeader(title: '稳定区'),
        ...MockData.earnProducts.where((p) => p['type'] == '稳定区').map((p) => _product(context, p)),

        const SectionHeader(title: '成长区'),
        ...MockData.earnProducts.where((p) => p['type'] == '成长区').map((p) => _product(context, p)),

        // Savings goal
        const SectionHeader(title: 'AI 储蓄目标'),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('6个月存 \$3,000', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
                    child: const Text('42%', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: const LinearProgressIndicator(value: 0.42, backgroundColor: AppColors.separatorLight, color: AppColors.primary, minHeight: 10),
              ),
              const SizedBox(height: 12),
              const Text('已存 \$1,260 / \$3,000 · 预计8月达成', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
            ],
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _product(BuildContext context, Map<String, dynamic> p) {
    final color = Color(p['color'] as int);
    final hasDeposit = p['deposited'] != '\$0';
    return GlassCard(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
            child: Center(child: Icon(Icons.show_chart_rounded, color: color, size: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                const SizedBox(height: 3),
                Text(hasDeposit ? '已投 ${p['deposited']} · 收益 ${p['earning']}' : '${p['minAmount']} 起投', style: TextStyle(fontSize: 13, color: hasDeposit ? AppColors.textSecondary : AppColors.textTertiary)),
              ],
            ),
          ),
          Text('${p['apy']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ),
    );
  }
}
