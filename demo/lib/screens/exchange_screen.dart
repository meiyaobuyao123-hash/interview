import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('换汇中心')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main exchange card
            InfoCard(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('USDT → THB', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('当前汇率', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      Text('35.82', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Percentile bar
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('30天分位', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      Text('78% 偏贵', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.accent)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(value: 0.78, backgroundColor: AppColors.divider, color: AppColors.accent, minHeight: 8),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome_rounded, color: AppColors.accent, size: 18),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('当前汇率偏高，如不急可等1-2天。上次最低点(5天前)：35.41', style: TextStyle(fontSize: 13, color: AppColors.textSecondary))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => showMockSuccess(context, '换汇成功！\n500 USDT → ฿17,910'),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                            child: const Text('立即换汇', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => showMockSuccess(context, '已设置目标价提醒\n当 USDT/THB ≤ 35.40 时通知您'),
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('设置目标价', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // All rates
            const SectionHeader(title: '全部汇率'),
            InfoCard(
              child: Column(
                children: MockData.fxRates.asMap().entries.map((entry) {
                  final rate = entry.value;
                  final isLast = entry.key == MockData.fxRates.length - 1;
                  final percentile = rate['percentile'] as int;
                  Color pColor = percentile > 70 ? AppColors.accent : percentile < 40 ? AppColors.earningGreen : AppColors.textSecondary;
                  String pLabel = percentile > 70 ? '偏贵' : percentile < 40 ? '较优' : '适中';
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rate['pair'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                  Text(rate['trend'] as String, style: TextStyle(fontSize: 12, color: (rate['trend'] as String).startsWith('+') ? AppColors.danger : AppColors.earningGreen)),
                                ],
                              ),
                            ),
                            Expanded(child: Text(rate['rate'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: pColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                                child: Text('$percentile% $pLabel', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: pColor), textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast) const Divider(height: 1, color: AppColors.divider),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
