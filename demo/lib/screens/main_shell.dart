import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'transfer_screen.dart';
import 'card_screen.dart';
import 'earn_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;
  final _screens = const [HomeScreen(), TransferScreen(), CardScreen(), EarnScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _i, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: C.white, border: Border(top: BorderSide(color: C.grey200, width: 0.5))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tab(Icons.house_rounded, '首页', 0),
                _tab(Icons.arrow_outward_rounded, '转账', 1),
                _tab(Icons.credit_card_rounded, 'U卡', 2),
                _tab(Icons.show_chart_rounded, '赚钱', 3),
                _tab(Icons.person_rounded, '我的', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(IconData icon, String label, int idx) {
    final on = _i == idx;
    return GestureDetector(
      onTap: () => setState(() => _i = idx),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: on ? C.brand : C.grey300),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: on ? FontWeight.w600 : FontWeight.w400, color: on ? C.brand : C.grey300)),
          ],
        ),
      ),
    );
  }
}
