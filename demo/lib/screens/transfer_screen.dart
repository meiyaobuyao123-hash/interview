import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int _mode = 0; // 0=跨境汇款, 1=本地转账, 2=链上转账
  final _amountController = TextEditingController(text: '500');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('转账')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Mode selector
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: AppColors.divider.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  _modeTab('跨境汇款', 0),
                  _modeTab('本地转账', 1),
                  _modeTab('链上转账', 2),
                ],
              ),
            ),

            if (_mode == 0) _buildRemittanceFlow(),
            if (_mode == 1) _buildLocalTransfer(),
            if (_mode == 2) _buildOnChainTransfer(),
          ],
        ),
      ),
    );
  }

  Widget _modeTab(String label, int index) {
    final selected = _mode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: selected ? AppColors.textPrimary : AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildRemittanceFlow() {
    return Column(
      children: [
        // Amount input
        InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('汇款金额', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('\$', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: AppColors.textTertiary)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('USDT', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      const Text('余额: \$8,200', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('≈ ₱28,115  |  ≈ ฿17,910', style: TextStyle(fontSize: 13, color: AppColors.textTertiary)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // AI Rate suggestion
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.earningGreen.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.earningGreen.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: AppColors.earningGreen, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AI 汇率评分', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.earningGreen)),
                    const SizedBox(height: 2),
                    const Text('当前汇率处于30天78分位，比昨天好0.3%，建议现在汇', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Recipient
        InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('收款人', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              _infoRow('姓名', '张伟'),
              _infoRow('手机号', '+86 138****8888'),
              _infoRow('收款方式', 'GCash · +63 917****1234'),
              _infoRow('到账币种', '菲律宾比索 (PHP)'),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Fee breakdown
        InfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('费用明细', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 10),
              _feeRow('汇款金额', '\$500.00'),
              _feeRow('手续费', '\$1.50 (0.3%)'),
              _feeRow('汇率', '1 USDT = 56.23 PHP'),
              const Divider(color: AppColors.divider),
              _feeRow('收款人收到', '₱28,045', bold: true),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: AppColors.earningGreen, size: 16),
                  const SizedBox(width: 6),
                  const Text('比 Western Union 省 ₱1,180', style: TextStyle(fontSize: 13, color: AppColors.earningGreen, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Submit
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => showMockSuccess(context, '汇款成功！\n₱28,045 将在30分钟内到账\n已通知收款人'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: const Text('确认汇款', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildLocalTransfer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InfoCard(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            const Icon(Icons.phone_android_rounded, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text('输入手机号即可转账', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('对方自动收到本地货币\n无需注册 SEA Wallet', style: TextStyle(fontSize: 14, color: AppColors.textSecondary), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: '输入收款人手机号',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnChainTransfer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InfoCard(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            const Icon(Icons.link_rounded, size: 48, color: AppColors.accent),
            const SizedBox(height: 16),
            const Text('链上转账', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('输入钱包地址\n支持 Tron / BSC / Ethereum', style: TextStyle(fontSize: 14, color: AppColors.textSecondary), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: '粘贴钱包地址',
                suffixIcon: const Icon(Icons.qr_code_scanner_rounded),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _feeRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: bold ? AppColors.textPrimary : AppColors.textSecondary, fontWeight: bold ? FontWeight.w600 : FontWeight.w400)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
