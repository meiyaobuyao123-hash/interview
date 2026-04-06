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
      appBar: AppBar(title: const Text('赚钱')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earn summary
            InfoCard(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('理财总资产', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  const Text('\$4,200.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  const Text('≈ ₱236,166', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _statBadge('累计收益', '+\$128.50', AppColors.earningGreen),
                      const SizedBox(width: 12),
                      _statBadge('昨日收益', '+\$2.38', AppColors.earningGreen),
                    ],
                  ),
                ],
              ),
            ),

            // AI suggestion
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.earningGreen.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome_rounded, color: AppColors.earningGreen, size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('您有\$8,500闲置USDT未理财，放入活期月赚约\$42，相当于多12顿饭钱', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ),
                  TextButton(onPressed: () => showMockSuccess(context, '已存入 \$8,500 到 USDT活期\n预计月收益 \$42'), child: const Text('存入', style: TextStyle(fontSize: 13))),
                ],
              ),
            ),

            // Product sections
            const SectionHeader(title: '稳定区 · 低风险稳定收益'),
            ...MockData.earnProducts.where((p) => p['type'] == '稳定区').map((p) => _buildProductCard(context, p)),

            const SectionHeader(title: '成长区 · 定投与质押'),
            ...MockData.earnProducts.where((p) => p['type'] == '成长区').map((p) => _buildProductCard(context, p)),

            // Savings goal
            const SectionHeader(title: 'AI 储蓄目标'),
            InfoCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('6个月存 \$3,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                        child: const Text('进行中', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(value: 0.42, backgroundColor: AppColors.divider, color: AppColors.primary, minHeight: 8),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('已存 \$1,260 / \$3,000', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      Text('42%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('AI每月自动存入\$500，预计8月达成目标', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final color = Color(product['color'] as int);
    final hasDeposit = product['deposited'] != '\$0';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.savings_rounded, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    Text('${product['minAmount']} 起投', style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('APY ${product['apy']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
                  if (hasDeposit) Text('已投 ${product['deposited']}', style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                ],
              ),
            ],
          ),
          if (hasDeposit) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('收益: ${product['earning']}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: (product['earning'] as String).startsWith('-') ? AppColors.danger : AppColors.earningGreen)),
                  GestureDetector(
                    onTap: () => showMockSuccess(context, '已追加 \$100 到 ${product['name']}'),
                    child: const Text('追加', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ],
          if (!hasDeposit) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton(
                onPressed: () => showMockSuccess(context, '已存入 \$100 到 ${product['name']}'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: color.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('立即存入', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _statBadge(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            const SizedBox(height: 2),
            Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ),
    );
  }
}
