import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _selected = -1;

  final List<Map<String, dynamic>> _options = [
    {'icon': Icons.send_rounded, 'label': '跨境汇款', 'desc': '给家人打钱，低费率秒到账', 'color': AppColors.primary},
    {'icon': Icons.savings_rounded, 'label': '存钱理财', 'desc': '稳定币活期，年化6-8%', 'color': AppColors.secondary},
    {'icon': Icons.credit_card_rounded, 'label': '刷卡消费', 'desc': 'U卡全球刷，Apple Pay支付', 'color': AppColors.accent},
    {'icon': Icons.store_rounded, 'label': '收款做生意', 'desc': '商户收款、发薪、对账一体化', 'color': AppColors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text('你好 👋', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              const SizedBox(height: 8),
              const Text('你主要想用来做什么？', style: TextStyle(fontSize: 20, color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              const Text('我们会为你优先展示相关功能', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 36),
              Expanded(
                child: ListView.separated(
                  itemCount: _options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final opt = _options[index];
                    final selected = _selected == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: selected ? (opt['color'] as Color).withValues(alpha: 0.08) : AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected ? opt['color'] as Color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (opt['color'] as Color).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(opt['icon'] as IconData, color: opt['color'] as Color, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(opt['label'] as String, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(opt['desc'] as String, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                            if (selected) Icon(Icons.check_circle_rounded, color: opt['color'] as Color, size: 24),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected >= 0 ? () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainShell()),
                    );
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.divider,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('开始使用', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
