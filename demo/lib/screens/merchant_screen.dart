import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';
import '../widgets/common_widgets.dart';

class MerchantScreen extends StatelessWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('商户工具'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('切换个人', style: TextStyle(color: AppColors.primary, fontSize: 14))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Daily report
            _buildDailyReport(context),
            const SizedBox(height: 12),
            // Quick actions
            _buildMerchantActions(context),
            const SizedBox(height: 4),
            // Today's transactions
            SectionHeader(title: '今日流水', action: '全部', onAction: () {}),
            _buildTodayFlow(),
            const SizedBox(height: 4),
            // Employee payroll
            SectionHeader(title: '员工管理', action: '批量发薪', onAction: () => _showPayroll(context)),
            _buildEmployeeList(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyReport(BuildContext context) {
    final report = MockData.aiDailyReport;
    return InfoCard(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Text('AI 日报 · ${report['date']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _reportStat('收款', report['totalReceived'] as String, AppColors.earningGreen),
              _reportStat('支出', report['totalSpent'] as String, AppColors.danger),
              _reportStat('净流入', report['netInflow'] as String, AppColors.primary),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text('汇率 ${report['fxPercentile']}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.accent)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(report['suggestion'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, color: AppColors.earningGreen, size: 16),
                    const SizedBox(width: 6),
                    Expanded(child: Text(report['earningSuggestion'] as String, style: const TextStyle(fontSize: 13, color: AppColors.earningGreen))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _buildMerchantActions(BuildContext context) {
    return InfoCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(icon: Icons.qr_code_2_rounded, label: '收款码', color: AppColors.secondary, onTap: () => _showQRCode(context)),
          ActionButton(icon: Icons.camera_alt_rounded, label: 'AI对账', color: AppColors.primary, onTap: () => showMockSuccess(context, '已识别微信账单3笔\n自动匹配链上记录\n差异: ¥0')),
          ActionButton(icon: Icons.groups_rounded, label: '发薪', color: AppColors.accent, onTap: () => _showPayroll(context)),
          ActionButton(icon: Icons.description_rounded, label: '月报', color: AppColors.purple, onTap: () => showMockSuccess(context, '已生成3月财务报表\n收入: \$18,500\n支出: \$12,300\n利润: \$6,200\nPDF已保存')),
        ],
      ),
    );
  }

  Widget _buildTodayFlow() {
    return InfoCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: MockData.merchantTransactions.asMap().entries.map((entry) {
          final tx = entry.value;
          final isLast = entry.key == MockData.merchantTransactions.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.earningGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_downward_rounded, color: AppColors.earningGreen, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tx['customer'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                          Text('${tx['type']} · ${tx['currency']}', style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('+${tx['amount']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.earningGreen)),
                        Text(tx['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 1, indent: 64, color: AppColors.divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmployeeList(BuildContext context) {
    return InfoCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: MockData.employees.asMap().entries.map((entry) {
          final emp = entry.value;
          final isLast = entry.key == MockData.employees.length - 1;
          final isPaid = emp['status'] == '已发放';
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text((emp['name'] as String)[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(emp['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                          Text(emp['role'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(emp['salary'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isPaid ? AppColors.earningGreen.withValues(alpha: 0.1) : AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(emp['status'] as String, style: TextStyle(fontSize: 11, color: isPaid ? AppColors.earningGreen : AppColors.accent, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 1, indent: 56, color: AppColors.divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showQRCode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Text('金龙餐厅', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('收款码', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Container(
              width: 200, height: 200,
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.qr_code_2_rounded, size: 160, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            const Text('USDT / THB 双币种支持', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.save_alt_rounded, size: 18),
                    label: const Text('保存图片'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.print_rounded, size: 18),
                    label: const Text('打印'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showPayroll(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('批量发薪', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('需要双签审批', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 20),
              _payrollRow('Nguyen Thi', '₫5,000,000'),
              _payrollRow('Lin Wei', '฿10,000'),
              const Divider(color: AppColors.divider),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('总计 (USDT)', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('\$480', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('取消'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        showMockSuccess(context, '发薪审批已发起\n等待财务双签确认\n\nNguyen Thi → ₫5,000,000\nLin Wei → ฿10,000');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                      child: const Text('发起审批'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _payrollRow(String name, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 15)),
          Text(amount, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
