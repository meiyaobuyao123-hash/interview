import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'merchant_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('我的')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            InfoCard(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: const Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Eathon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: AppColors.earningGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: const Text('KYC 已认证', style: TextStyle(fontSize: 12, color: AppColors.earningGreen, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                ],
              ),
            ),

            // Merchant mode
            InfoCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MerchantScreen()));
              },
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.purple, Color(0xFFAF52DE)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.store_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('商户模式', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text('收款 · 对账 · 发薪 · 报表', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.purple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Text('进入', style: TextStyle(fontSize: 13, color: AppColors.purple, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Settings groups
            _buildSettingsGroup([
              _settingItem(Icons.language_rounded, '语言', '简体中文', AppColors.primary),
              _settingItem(Icons.attach_money_rounded, '基准货币', 'USD', AppColors.secondary),
              _settingItem(Icons.notifications_none_rounded, '通知设置', '', AppColors.accent),
            ]),
            const SizedBox(height: 12),

            _buildSettingsGroup([
              _settingItem(Icons.shield_outlined, '安全设置', '', AppColors.danger),
              _settingItem(Icons.fingerprint_rounded, 'Face ID / 指纹', '已开启', AppColors.teal),
              _settingItem(Icons.key_rounded, 'MPC 密钥备份', '已备份', AppColors.earningGreen),
            ]),
            const SizedBox(height: 12),

            _buildSettingsGroup([
              _settingItem(Icons.gavel_rounded, 'AI 合规助手', '6国政策', AppColors.purple),
              _settingItem(Icons.history_rounded, 'AI 对话历史', '', AppColors.primary),
              _settingItem(Icons.support_agent_rounded, '人工客服', '24h 中文', AppColors.secondary),
            ]),
            const SizedBox(height: 12),

            _buildSettingsGroup([
              _settingItem(Icons.info_outline_rounded, '关于 SEA Wallet', 'v1.0.0', AppColors.textSecondary),
            ]),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> items) {
    return InfoCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.asMap().entries.map((entry) {
          return Column(
            children: [
              entry.value,
              if (entry.key < items.length - 1) const Divider(height: 1, indent: 56, color: AppColors.divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _settingItem(IconData icon, String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          if (value.isNotEmpty) Text(value, style: const TextStyle(fontSize: 14, color: AppColors.textTertiary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}
