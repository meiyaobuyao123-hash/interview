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
      appBar: AppBar(title: const Text('换汇中心'), backgroundColor: AppColors.background),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Main exchange
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('USDT → THB', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                        child: const Text('78% 偏贵', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.accent)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(child: Text('35.82', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5))),
                  const SizedBox(height: 20),

                  // Percentile bar
                  Row(
                    children: [
                      const Text('便宜', style: TextStyle(fontSize: 12, color: AppColors.earning)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [AppColors.earning, AppColors.accent, AppColors.danger]),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.78 * 0.6,
                              top: -2,
                              child: Container(
                                width: 14, height: 14,
                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.accent, width: 3)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('贵', style: TextStyle(fontSize: 12, color: AppColors.danger)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // AI suggestion
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded, color: AppColors.accent, size: 18),
                        const SizedBox(width: 10),
                        const Expanded(child: Text('当前汇率偏高，如不急可等1-2天\n5天前最低点：35.41', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '换汇成功！\n500 USDT → ฿17,910')),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            child: const Text('立即换汇', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () => showMockSuccess(context, '已设置目标价提醒\nUSDT/THB ≤ 35.40 时通知'),
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            child: const Text('目标价', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SectionHeader(title: '全部汇率'),
            GlassCard(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: MockData.fxRates.asMap().entries.map((e) {
                  final r = e.value;
                  final isLast = e.key == MockData.fxRates.length - 1;
                  final p = r['percentile'] as int;
                  Color pc = p > 70 ? AppColors.accent : p < 40 ? AppColors.earning : AppColors.textTertiary;
                  String pl = p > 70 ? '偏贵' : p < 40 ? '较优' : '适中';
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(r['pair'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                                  const SizedBox(height: 2),
                                  Text(r['trend'] as String, style: TextStyle(fontSize: 13, color: (r['trend'] as String).startsWith('+') ? AppColors.danger : AppColors.earning)),
                                ],
                              ),
                            ),
                            Expanded(flex: 2, child: Text(r['rate'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: pc.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                              child: Text('$p% $pl', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: pc)),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast) const Padding(padding: EdgeInsets.only(left: 20, right: 20), child: Divider(height: 1, color: AppColors.separatorLight)),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
