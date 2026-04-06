import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _currentCard = 0;
  final List<Map<String, dynamic>> _cards = [
    {'name': '生活卡', 'balance': '\$2,100', 'last4': '8842', 'colors': const [Color(0xFF1C1C1E), Color(0xFF3A3A3C)], 'frozen': false},
    {'name': '差旅卡', 'balance': '\$1,400', 'last4': '3356', 'colors': const [Color(0xFF0A84FF), Color(0xFF64D2FF)], 'frozen': false},
    {'name': '订阅卡', 'balance': '\$89.99', 'last4': '7721', 'colors': const [Color(0xFF5856D6), Color(0xFFBF5AF2)], 'frozen': true},
  ];

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
            title: const Text('U卡'),
            actions: [
              TextButton(
                onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '新卡申请已提交')),
                child: const Text('申请新卡', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Card carousel
        SizedBox(
          height: 220,
          child: PageView.builder(
            itemCount: _cards.length,
            controller: PageController(viewportFraction: 0.85),
            onPageChanged: (i) => setState(() => _currentCard = i),
            itemBuilder: (context, index) => _buildCard(_cards[index], index == _currentCard),
          ),
        ),
        const SizedBox(height: 12),
        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_cards.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: i == _currentCard ? 20 : 6, height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: i == _currentCard ? AppColors.primary : AppColors.textQuaternary,
              borderRadius: BorderRadius.circular(3),
            ),
          )),
        ),
        const SizedBox(height: 24),

        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PillAction(icon: Icons.add_rounded, label: '充值', gradient: AppColors.gradientBlue, onTap: () => showMockSuccess(context, '充值 \$500 USDT 成功')),
              PillAction(icon: Icons.ac_unit_rounded, label: _cards[_currentCard]['frozen'] ? '解冻' : '冻结', gradient: const [Color(0xFF64D2FF), Color(0xFF5AC8FA)], onTap: () => setState(() => _cards[_currentCard]['frozen'] = !_cards[_currentCard]['frozen'])),
              PillAction(icon: Icons.apple, label: 'Apple Pay', gradient: const [Color(0xFF1C1C1E), Color(0xFF3A3A3C)], onTap: () => showMockSuccess(context, '已绑定 Apple Pay')),
              PillAction(icon: Icons.receipt_long_rounded, label: '报销单', gradient: AppColors.gradientOrange, onTap: () => showMockSuccess(context, '已生成3月报销单PDF\n共28笔 \$2,340')),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Travel mode
        GlassCard(
          onTap: () => showMockSuccess(context, '已启用旅行模式\n\n目的地：新加坡 3天\n建议预算：SGD 1,500\nUSDT/SGD 处于65分位'),
          child: Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: AppColors.gradientPurple),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.flight_takeoff_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('旅行模式', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                    SizedBox(height: 3),
                    Text('AI 自动配置权限 · 预算 · 汇率提醒', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textQuaternary),
            ],
          ),
        ),

        // Spending
        SectionHeader(title: '消费记录', action: '全部', onAction: () {}),
        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              _spend('Grab Food', '餐饮 · 曼谷', '-\$12.50', '今天 12:15', Icons.restaurant_rounded, AppColors.accent),
              _divider(),
              _spend('7-Eleven', '购物', '-\$6.80', '今天 09:30', Icons.shopping_bag_rounded, AppColors.primary),
              _divider(),
              _spend('BTS Skytrain', '交通', '-\$1.40', '昨天 18:20', Icons.train_rounded, AppColors.secondary),
              _divider(),
              _spend('ChatGPT Plus', '订阅', '-\$20.00', '4月1日', Icons.smart_toy_rounded, AppColors.purple),
            ],
          ),
        ),

        // Monthly analysis
        SectionHeader(title: '3月消费分析'),
        GlassCard(
          child: Column(
            children: [
              _bar('餐饮', 0.35, AppColors.accent, '\$420'),
              _bar('购物', 0.28, AppColors.primary, '\$336'),
              _bar('交通', 0.15, AppColors.secondary, '\$180'),
              _bar('订阅', 0.12, AppColors.purple, '\$144'),
              _bar('其他', 0.10, AppColors.textTertiary, '\$120'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: AppColors.separatorLight)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('总计', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('\$1,200', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      Text('返现 \$18.60', style: TextStyle(fontSize: 13, color: AppColors.earning, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildCard(Map<String, dynamic> card, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: active ? 0 : 12),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: card['colors'] as List<Color>, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: active ? [BoxShadow(color: (card['colors'] as List<Color>)[0].withValues(alpha: 0.35), blurRadius: 30, offset: const Offset(0, 12))] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card['name'] as String, style: const TextStyle(color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.5)),
              if (card['frozen'] as bool)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                  child: const Text('已冻结', style: TextStyle(color: Colors.white70, fontSize: 12)),
                )
              else
                const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3)),
            ],
          ),
          const Spacer(),
          Text(card['balance'] as String, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('•••• •••• •••• ${card['last4']}', style: const TextStyle(color: Colors.white38, fontSize: 15, letterSpacing: 2.5)),
              const Text('12/28', style: TextStyle(color: Colors.white38, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spend(String title, String sub, String amount, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -0.3)),
                const SizedBox(height: 2),
                Text(sub, style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -0.3)),
              Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textQuaternary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Padding(padding: EdgeInsets.only(left: 78), child: Divider(height: 1, color: AppColors.separatorLight));

  Widget _bar(String label, double ratio, Color color, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 36, child: Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary))),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: ratio, backgroundColor: AppColors.separatorLight, color: color, minHeight: 8),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(width: 52, child: Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
