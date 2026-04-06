import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int _mode = 0;
  final _amountCtrl = TextEditingController(text: '500');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('转账'), backgroundColor: AppColors.background),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Mode selector
            Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: AppColors.separatorLight.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(12)),
              child: Row(children: [_tab('跨境汇款', 0), _tab('本地转账', 1), _tab('链上转账', 2)]),
            ),
            if (_mode == 0) _remittance(),
            if (_mode == 1) _localTransfer(),
            if (_mode == 2) _onChain(),
          ],
        ),
      ),
    );
  }

  Widget _tab(String label, int i) {
    final on = _mode == i;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: on ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: on ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)] : [],
          ),
          child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: on ? FontWeight.w600 : FontWeight.w400, color: on ? AppColors.textPrimary : AppColors.textTertiary)),
        ),
      ),
    );
  }

  Widget _remittance() {
    return Column(
      children: [
        // Amount
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('汇款金额', style: TextStyle(fontSize: 14, color: AppColors.textTertiary, letterSpacing: -0.1)),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text('\$', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: AppColors.textQuaternary)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _amountCtrl,
                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w700, letterSpacing: -1),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
                    child: const Text('USDT', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('余额 \$8,200.00  ·  ≈ ₱28,115', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // AI
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientGreen), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI 汇率评分 78/100', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.earning)),
                    SizedBox(height: 2),
                    Text('30天78分位，比昨天好0.3%，建议现在汇', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Recipient
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('收款人', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
              const SizedBox(height: 16),
              _row('姓名', '张伟'),
              _row('收款方式', 'GCash · +63 917****1234'),
              _row('到账币种', '菲律宾比索 (PHP)'),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Fee
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row('手续费', '\$1.50 (0.3%)'),
              _row('汇率', '1 USDT = 56.23 PHP'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: AppColors.separatorLight),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('收款人收到', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const Text('₱28,045', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: AppColors.earning.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.savings_rounded, color: AppColors.earning, size: 16),
                    const SizedBox(width: 8),
                    Text('比 Western Union 省 ₱1,180', style: TextStyle(fontSize: 14, color: AppColors.earning, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity, height: 56,
            child: ElevatedButton(
              onPressed: () => showAuthSheet(context, onSuccess: () => showMockSuccess(context, '汇款成功！\n₱28,045 将在30分钟内到账\n已通知收款人')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('确认汇款', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _localTransfer() {
    return GlassCard(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientBlue), borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.phone_android_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 20),
          const Text('输入手机号即可转账', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
          const SizedBox(height: 8),
          const Text('对方无需注册，直接到账本地货币', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
          const SizedBox(height: 28),
          TextField(
            decoration: InputDecoration(
              hintText: '输入收款人手机号',
              hintStyle: const TextStyle(color: AppColors.textQuaternary),
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textTertiary),
              filled: true, fillColor: AppColors.background,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _onChain() {
    return GlassCard(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: AppColors.gradientOrange), borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.link_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 20),
          const Text('链上转账', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
          const SizedBox(height: 8),
          const Text('支持 Tron / BSC / Ethereum', style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
          const SizedBox(height: 28),
          TextField(
            decoration: InputDecoration(
              hintText: '粘贴钱包地址',
              hintStyle: const TextStyle(color: AppColors.textQuaternary),
              suffixIcon: const Icon(Icons.qr_code_scanner_rounded, color: AppColors.textTertiary),
              filled: true, fillColor: AppColors.background,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15, color: AppColors.textTertiary)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
