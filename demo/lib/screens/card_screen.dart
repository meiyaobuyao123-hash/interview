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
    {'name': '生活卡', 'balance': '\$2,100', 'last4': '8842', 'color1': Color(0xFF0A84FF), 'color2': Color(0xFF5AC8FA), 'frozen': false},
    {'name': '差旅卡', 'balance': '\$1,400', 'last4': '3356', 'color1': Color(0xFF5856D6), 'color2': Color(0xFFAF52DE), 'frozen': false},
    {'name': '订阅卡', 'balance': '\$89.99', 'last4': '7721', 'color1': Color(0xFFFF9500), 'color2': Color(0xFFFF6B35), 'frozen': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('U卡'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('申请新卡', style: TextStyle(color: AppColors.primary))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card carousel
            SizedBox(
              height: 210,
              child: PageView.builder(
                itemCount: _cards.length,
                controller: PageController(viewportFraction: 0.88),
                onPageChanged: (i) => setState(() => _currentCard = i),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return _buildCardWidget(card, index == _currentCard);
                },
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_cards.length, (i) => Container(
                width: i == _currentCard ? 18 : 6, height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: i == _currentCard ? AppColors.primary : AppColors.divider,
                  borderRadius: BorderRadius.circular(3),
                ),
              )),
            ),
            const SizedBox(height: 16),

            // Quick card actions
            InfoCard(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionButton(icon: Icons.add_rounded, label: '充值', color: AppColors.primary, onTap: () => showMockSuccess(context, '充值 \$500 USDT 成功')),
                  ActionButton(icon: Icons.ac_unit_rounded, label: _cards[_currentCard]['frozen'] ? '解冻' : '冻结', color: AppColors.teal, onTap: () {
                    setState(() => _cards[_currentCard]['frozen'] = !_cards[_currentCard]['frozen']);
                  }),
                  ActionButton(icon: Icons.apple, label: 'Apple Pay', color: AppColors.textPrimary, onTap: () => showMockSuccess(context, '已绑定 Apple Pay')),
                  ActionButton(icon: Icons.receipt_long_rounded, label: '报销单', color: AppColors.accent, onTap: () => showMockSuccess(context, '已生成3月报销单PDF\n共28笔 \$2,340')),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // AI travel mode
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.purple.withValues(alpha: 0.08), AppColors.primary.withValues(alpha: 0.04)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: AppColors.purple.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.flight_takeoff_rounded, color: AppColors.purple, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('旅行模式', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text('输入目的地，AI自动配置刷卡权限和预算', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Switch(value: false, onChanged: (v) => showMockSuccess(context, '已启用旅行模式\n目的地：新加坡 3天\n建议预算：SGD 1,500\n当前USDT/SGD处于65分位')),
                ],
              ),
            ),

            // Recent card spending
            SectionHeader(title: '近期消费', action: '全部', onAction: () {}),
            InfoCard(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  _spendItem('Grab Food', '餐饮', '-\$12.50', '今天 12:15', Icons.restaurant_rounded, AppColors.accent),
                  const Divider(height: 1, indent: 56, color: AppColors.divider),
                  _spendItem('7-Eleven', '购物', '-\$6.80', '今天 09:30', Icons.shopping_bag_rounded, AppColors.primary),
                  const Divider(height: 1, indent: 56, color: AppColors.divider),
                  _spendItem('BTS Skytrain', '交通', '-\$1.40', '昨天 18:20', Icons.train_rounded, AppColors.secondary),
                  const Divider(height: 1, indent: 56, color: AppColors.divider),
                  _spendItem('ChatGPT Plus', '订阅', '-\$20.00', '4月1日', Icons.smart_toy_rounded, AppColors.purple),
                  const Divider(height: 1, indent: 56, color: AppColors.divider),
                  _spendItem('Shopee', '购物', '-\$35.20', '3月30日', Icons.shopping_cart_rounded, AppColors.danger),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Monthly summary
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('3月消费分析', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _categoryBar('餐饮', 0.35, AppColors.accent, '\$420'),
                  _categoryBar('交通', 0.15, AppColors.secondary, '\$180'),
                  _categoryBar('购物', 0.28, AppColors.primary, '\$336'),
                  _categoryBar('订阅', 0.12, AppColors.purple, '\$144'),
                  _categoryBar('其他', 0.10, AppColors.textTertiary, '\$120'),
                  const Divider(color: AppColors.divider),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('总计', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      Text('\$1,200', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('已获返现 \$18.60 (1.55%)', style: TextStyle(fontSize: 13, color: AppColors.earningGreen, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWidget(Map<String, dynamic> card, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: active ? 8 : 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [card['color1'] as Color, card['color2'] as Color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: active ? [BoxShadow(color: (card['color1'] as Color).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card['name'] as String, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
              if (card['frozen'] as bool)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6)),
                  child: const Text('已冻结', style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
              if (!(card['frozen'] as bool))
                const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 2)),
            ],
          ),
          const Spacer(),
          Text(card['balance'] as String, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('•••• •••• •••• ${card['last4']}', style: const TextStyle(color: Colors.white60, fontSize: 14, letterSpacing: 2)),
              const Text('12/28', style: TextStyle(color: Colors.white60, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spendItem(String title, String category, String amount, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Text(category, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryBar(String label, double ratio, Color color, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(value: ratio, backgroundColor: AppColors.divider, color: color, minHeight: 6),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 50, child: Text(amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
