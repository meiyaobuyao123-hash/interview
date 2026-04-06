import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';

// ──────────── Card ────────────
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  const AppCard({super.key, required this.child, this.margin, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
    return onTap != null ? GestureDetector(onTap: onTap, child: w) : w;
  }
}

// ──────────── Section ────────────
class Section extends StatelessWidget {
  final String title;
  final String? trailing;
  final VoidCallback? onTrailing;
  const Section({super.key, required this.title, this.trailing, this.onTrailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          if (trailing != null) GestureDetector(onTap: onTrailing, child: Text(trailing!, style: const TextStyle(fontSize: 15, color: C.brand))),
        ],
      ),
    );
  }
}

// ──────────── Quick Action ────────────
class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled; // true = brand fill, false = outline
  const QuickAction({super.key, required this.icon, required this.label, required this.onTap, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: filled ? C.brand : C.grey100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: filled ? C.white : C.grey700, size: 22),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, color: C.grey700, letterSpacing: -0.1)),
        ],
      ),
    );
  }
}

// ──────────── Transaction ────────────
class TxTile extends StatelessWidget {
  final Map<String, dynamic> tx;
  const TxTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final pos = tx['amount'].toString().startsWith('+');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: C.grey100, borderRadius: BorderRadius.circular(14)),
            child: Icon(_icon(tx['icon'] as String), color: C.grey700, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -0.3)),
                const SizedBox(height: 2),
                Text(tx['subtitle'], style: const TextStyle(fontSize: 13, color: C.grey500)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tx['amount'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.3, color: pos ? C.green : C.black)),
              const SizedBox(height: 2),
              Text(tx['time'], style: const TextStyle(fontSize: 12, color: C.grey300)),
            ],
          ),
        ],
      ),
    );
  }

  IconData _icon(String key) {
    switch (key) {
      case 'arrow_downward': return Icons.south_rounded;
      case 'arrow_upward': return Icons.north_rounded;
      case 'credit_card': return Icons.credit_card_rounded;
      case 'trending_up': return Icons.show_chart_rounded;
      case 'store': return Icons.storefront_rounded;
      default: return Icons.swap_horiz_rounded;
    }
  }
}

// ──────────── Auth Sheet ────────────
void showAuthSheet(BuildContext context, {required VoidCallback onSuccess}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _Auth(onDone: () { Navigator.pop(ctx); onSuccess(); }),
  );
}

class _Auth extends StatefulWidget {
  final VoidCallback onDone;
  const _Auth({required this.onDone});
  @override
  State<_Auth> createState() => _AuthState();
}

class _AuthState extends State<_Auth> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Container(
        decoration: const BoxDecoration(color: C.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.fromLTRB(28, 12, 28, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: C.grey300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 32),
            if (_step == 0) ...[
              const Text('需要登录', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              const SizedBox(height: 8),
              const Text('登录后即可操作', style: TextStyle(fontSize: 15, color: C.grey500)),
              const SizedBox(height: 32),
              _btn(Icons.g_mobiledata_rounded, 'Google 登录'),
              const SizedBox(height: 10),
              _btn(Icons.apple_rounded, 'Apple 登录'),
              const SizedBox(height: 10),
              _btn(Icons.telegram, 'Telegram 登录'),
              const SizedBox(height: 24),
              const Text('无助记词 · MPC 安全托管', style: TextStyle(fontSize: 13, color: C.grey300)),
            ],
            if (_step == 1) ...[
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(color: C.brandLight, shape: BoxShape.circle),
                child: const Icon(Icons.face_rounded, color: C.brand, size: 36),
              ),
              const SizedBox(height: 20),
              const Text('Face ID 验证', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity, height: 54,
                child: ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('验证', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _btn(IconData icon, String label) {
    return SizedBox(
      width: double.infinity, height: 54,
      child: OutlinedButton(
        onPressed: () => setState(() => _step = 1),
        style: OutlinedButton.styleFrom(side: const BorderSide(color: C.grey200), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: C.grey900),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: C.grey900)),
          ],
        ),
      ),
    );
  }
}

// ──────────── Success ────────────
void showMockSuccess(BuildContext context, String msg) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'x',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (_, a, __, child) => Transform.scale(scale: .85 + .15 * a.value, child: Opacity(opacity: a.value, child: child)),
    pageBuilder: (ctx, _, __) => Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
        decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(20)),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 56, height: 56, decoration: const BoxDecoration(color: C.green, shape: BoxShape.circle), child: const Icon(Icons.check_rounded, color: C.white, size: 28)),
              const SizedBox(height: 20),
              Text(msg, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.6, letterSpacing: -0.2), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(backgroundColor: C.brand, foregroundColor: C.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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
