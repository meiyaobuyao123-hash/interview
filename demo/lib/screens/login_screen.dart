import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A84FF), Color(0xFF5AC8FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              const Text('SEA Wallet', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              const Text('东南亚 AI 跨境金融钱包', style: TextStyle(fontSize: 15, color: AppColors.textSecondary, letterSpacing: 0.2)),
              const SizedBox(height: 8),
              const Text('存 · 赚 · 花 · 转', style: TextStyle(fontSize: 13, color: AppColors.textTertiary, letterSpacing: 4)),
              const Spacer(flex: 2),

              // Login buttons
              _LoginButton(
                icon: Icons.g_mobiledata_rounded,
                iconColor: Colors.red,
                label: 'Continue with Google',
                onTap: () => _goToOnboarding(context),
              ),
              const SizedBox(height: 12),
              _LoginButton(
                icon: Icons.apple_rounded,
                iconColor: Colors.black,
                label: 'Continue with Apple',
                onTap: () => _goToOnboarding(context),
              ),
              const SizedBox(height: 12),
              _LoginButton(
                icon: Icons.telegram,
                iconColor: const Color(0xFF0088CC),
                label: 'Continue with Telegram',
                onTap: () => _goToOnboarding(context),
              ),
              const SizedBox(height: 12),
              _LoginButton(
                icon: Icons.email_outlined,
                iconColor: AppColors.textSecondary,
                label: '使用邮箱登录',
                onTap: () => _goToOnboarding(context),
              ),
              const Spacer(),

              // Footer
              const Text('无需助记词 · MPC安全托管 · 社交登录即可', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('登录即同意 ', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  Text('服务条款', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                  Text(' 和 ', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  Text('隐私政策', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _goToOnboarding(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  const _LoginButton({required this.icon, required this.iconColor, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.divider),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}
