import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';

// ──────────────────── Glass Card ────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double borderRadius;
  const GlassCard({super.key, required this.child, this.margin, this.padding, this.onTap, this.borderRadius = 16});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
    if (onTap != null) return GestureDetector(onTap: onTap, child: card);
    return card;
  }
}

// ──────────────────── Section Header ────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.4, color: AppColors.textPrimary)),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              child: Text(action!, style: const TextStyle(fontSize: 15, color: AppColors.primary, fontWeight: FontWeight.w400)),
            ),
        ],
      ),
    );
  }
}

// ──────────────────── Pill Action Button ────────────────────
class PillAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> gradient;
  final VoidCallback onTap;
  const PillAction({super.key, required this.icon, required this.label, required this.gradient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: gradient[0].withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary, letterSpacing: -0.2)),
        ],
      ),
    );
  }
}

// ──────────────────── Transaction Tile ────────────────────
class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> tx;
  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isPositive = tx['amount'].toString().startsWith('+');
    IconData iconData;
    switch (tx['icon']) {
      case 'arrow_downward': iconData = Icons.south_rounded; break;
      case 'arrow_upward': iconData = Icons.north_rounded; break;
      case 'credit_card': iconData = Icons.credit_card_rounded; break;
      case 'trending_up': iconData = Icons.show_chart_rounded; break;
      case 'store': iconData = Icons.storefront_rounded; break;
      default: iconData = Icons.swap_horiz_rounded;
    }

    Color iconColor;
    switch (tx['type']) {
      case 'receive': iconColor = AppColors.secondary; break;
      case 'send': iconColor = AppColors.primary; break;
      case 'card': iconColor = AppColors.accent; break;
      case 'earn': iconColor = AppColors.earning; break;
      case 'merchant': iconColor = AppColors.purple; break;
      default: iconColor = AppColors.textTertiary;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -0.3)),
                const SizedBox(height: 3),
                Text(tx['subtitle'], style: const TextStyle(fontSize: 13, color: AppColors.textTertiary, letterSpacing: -0.1)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tx['amount'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3, color: isPositive ? AppColors.earning : AppColors.textPrimary)),
              const SizedBox(height: 3),
              Text(tx['time'], style: const TextStyle(fontSize: 12, color: AppColors.textQuaternary)),
            ],
          ),
        ],
      ),
    );
  }
}

// ──────────────────── Auth Bottom Sheet ────────────────────
void showAuthSheet(BuildContext context, {required VoidCallback onSuccess}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _AuthSheet(onSuccess: () {
      Navigator.pop(ctx);
      onSuccess();
    }),
  );
}

class _AuthSheet extends StatefulWidget {
  final VoidCallback onSuccess;
  const _AuthSheet({required this.onSuccess});

  @override
  State<_AuthSheet> createState() => _AuthSheetState();
}

class _AuthSheetState extends State<_AuthSheet> {
  int _step = 0; // 0=login, 1=verify, 2=done

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 36, height: 5, decoration: BoxDecoration(color: AppColors.textQuaternary, borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 28),
            if (_step == 0) _buildLogin(),
            if (_step == 1) _buildVerify(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Column(
      children: [
        const Text('继续操作需要登录', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
        const SizedBox(height: 8),
        const Text('登录后可使用转账、开卡等功能', style: TextStyle(fontSize: 15, color: AppColors.textTertiary)),
        const SizedBox(height: 32),
        _authBtn(Icons.g_mobiledata_rounded, 'Continue with Google', const Color(0xFFEA4335)),
        const SizedBox(height: 12),
        _authBtn(Icons.apple_rounded, 'Continue with Apple', Colors.black),
        const SizedBox(height: 12),
        _authBtn(Icons.telegram, 'Continue with Telegram', const Color(0xFF0088CC)),
        const SizedBox(height: 24),
        const Text('无需助记词 · MPC安全托管', style: TextStyle(fontSize: 13, color: AppColors.textQuaternary)),
      ],
    );
  }

  Widget _buildVerify() {
    return Column(
      children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.face_rounded, color: AppColors.primary, size: 36),
        ),
        const SizedBox(height: 20),
        const Text('验证身份', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
        const SizedBox(height: 8),
        const Text('使用 Face ID 完成身份验证', style: TextStyle(fontSize: 15, color: AppColors.textTertiary)),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: widget.onSuccess,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text('验证', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _authBtn(IconData icon, String label, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () => setState(() => _step = 1),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.separatorLight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

// ──────────────────── Success Dialog ────────────────────
void showMockSuccess(BuildContext context, String message) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'dismiss',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 250),
    transitionBuilder: (ctx, a1, a2, child) {
      return Transform.scale(scale: 0.8 + 0.2 * a1.value, child: Opacity(opacity: a1.value, child: child));
    },
    pageBuilder: (ctx, _, __) => Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: AppColors.gradientGreen),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 20),
              Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: -0.3), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('完成', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
