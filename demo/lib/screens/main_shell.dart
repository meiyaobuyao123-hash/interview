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
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TransferScreen(),
    CardScreen(),
    EarnScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.swap_horiz_rounded), label: '转账'),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card_rounded), label: 'U卡'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up_rounded), label: '赚钱'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: '我的'),
          ],
        ),
      ),
    );
  }
}
