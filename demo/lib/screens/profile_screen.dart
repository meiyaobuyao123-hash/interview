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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(pinned: true, backgroundColor: AppColors.background, surfaceTintColor: Colors.transparent, title: const Text('我的')),
          SliverToBoxAdapter(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        // Profile
        GlassCard(
          child: Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: AppColors.gradientBlue),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Eathon', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.earning.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
                      child: const Text('KYC 已认证', style: TextStyle(fontSize: 12, color: AppColors.earning, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textQuaternary),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Merchant mode
        GlassCard(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MerchantScreen())),
          child: Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientPurple), borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('商户模式', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                    SizedBox(height: 3),
                    Text('收款 · 对账 · 发薪 · 报表', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientPurple), borderRadius: BorderRadius.circular(20)),
                child: const Text('进入', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _group([
          _item(Icons.language_rounded, '语言', '简体中文', AppColors.primary),
          _item(Icons.attach_money_rounded, '基准货币', 'USD', AppColors.earning),
          _item(Icons.notifications_none_rounded, '通知设置', '', AppColors.accent),
        ]),
        const SizedBox(height: 12),
        _group([
          _item(Icons.shield_outlined, '安全设置', '', AppColors.danger),
          _item(Icons.fingerprint_rounded, 'Face ID', '已开启', AppColors.teal),
          _item(Icons.key_rounded, 'MPC 密钥', '已备份', AppColors.earning),
        ]),
        const SizedBox(height: 12),
        _group([
          _item(Icons.gavel_rounded, 'AI 合规助手', '6国政策', AppColors.purple),
          _item(Icons.chat_bubble_outline_rounded, 'AI 对话', '', AppColors.primary),
          _item(Icons.support_agent_rounded, '人工客服', '24h 中文', AppColors.indigo),
        ]),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _group(List<Widget> items) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.asMap().entries.map((e) => Column(
          children: [
            e.value,
            if (e.key < items.length - 1) const Padding(padding: EdgeInsets.only(left: 64), child: Divider(height: 1, color: AppColors.separatorLight)),
          ],
        )).toList(),
      ),
    );
  }

  Widget _item(IconData icon, String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, letterSpacing: -0.2))),
          if (value.isNotEmpty) Text(value, style: const TextStyle(fontSize: 15, color: AppColors.textTertiary)),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textQuaternary, size: 20),
        ],
      ),
    );
  }
}
