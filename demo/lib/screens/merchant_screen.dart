import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class MerchantScreen extends StatelessWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: const Text('商户工具'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('返回个人', style: TextStyle(fontSize: 14))),
            ],
          ),
          SliverToBoxAdapter(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final r = MockData.aiDailyReport;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // AI report
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientBlue), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Text('AI 日报 · ${r['date']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _stat('收款', r['totalReceived'] as String, AppColors.earning),
                  const SizedBox(width: 10),
                  _stat('支出', r['totalSpent'] as String, AppColors.danger),
                  const SizedBox(width: 10),
                  _stat('净流入', r['netInflow'] as String, AppColors.primary),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['suggestion'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                    const SizedBox(height: 6),
                    Text(r['earningSuggestion'] as String, style: const TextStyle(fontSize: 13, color: AppColors.earning, height: 1.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PillAction(icon: Icons.qr_code_2_rounded, label: '收款码', gradient: AppColors.gradientGreen, onTap: () => _showQR(context)),
              PillAction(icon: Icons.camera_alt_rounded, label: 'AI对账', gradient: AppColors.gradientBlue, onTap: () => showMockSuccess(context, '已识别微信账单3笔\n自动匹配链上记录\n差异: ¥0')),
              PillAction(icon: Icons.groups_rounded, label: '发薪', gradient: AppColors.gradientOrange, onTap: () => _showPayroll(context)),
              PillAction(icon: Icons.description_rounded, label: '月报', gradient: AppColors.gradientPurple, onTap: () => showMockSuccess(context, '已生成3月财务报表\n收入 \$18,500\n支出 \$12,300\n利润 \$6,200')),
            ],
          ),
        ),

        // Today's flow
        SectionHeader(title: '今日流水', action: '全部', onAction: () {}),
        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: MockData.merchantTransactions.asMap().entries.map((e) {
              final tx = e.value;
              final isLast = e.key == MockData.merchantTransactions.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: AppColors.earning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.south_rounded, color: AppColors.earning, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx['customer'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text('${tx['type']} · ${tx['currency']}', style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('+${tx['amount']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.earning)),
                            Text(tx['time'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textQuaternary)),
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
        ),

        // Employees
        SectionHeader(title: '员工管理', action: '批量发薪', onAction: () => _showPayroll(context)),
        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: MockData.employees.asMap().entries.map((e) {
              final emp = e.value;
              final isLast = e.key == MockData.employees.length - 1;
              final isPaid = emp['status'] == '已发放';
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: isPaid ? AppColors.gradientGreen : AppColors.gradientOrange),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(child: Text((emp['name'] as String)[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white))),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(emp['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text(emp['role'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(emp['salary'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isPaid ? AppColors.earning.withValues(alpha: 0.08) : AppColors.accent.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(emp['status'] as String, style: TextStyle(fontSize: 11, color: isPaid ? AppColors.earning : AppColors.accent, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Padding(padding: EdgeInsets.only(left: 74), child: Divider(height: 1, color: AppColors.separatorLight)),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ),
    );
  }

  void _showQR(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 36, height: 5, decoration: BoxDecoration(color: AppColors.textQuaternary, borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 28),
              const Text('金龙餐厅', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('收款码 · USDT / THB 双币种', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 28),
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.qr_code_2_rounded, size: 160, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.save_alt_rounded, size: 18),
                    label: const Text('保存'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.print_rounded, size: 18),
                    label: const Text('打印'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPayroll(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 36, height: 5, decoration: BoxDecoration(color: AppColors.textQuaternary, borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 24),
              const Text('批量发薪', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('需要双签审批', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 24),
              _payRow('Nguyen Thi', '清洁', '₫5,000,000'),
              _payRow('Lin Wei', '收银', '฿10,000'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: AppColors.separatorLight)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('总计 (USDT)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('\$480', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    showMockSuccess(context, '发薪审批已发起\n等待财务双签确认');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('发起审批', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _payRow(String name, String role, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(role, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
