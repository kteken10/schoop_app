import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../constants/colors.dart';
import 'home.dart';
import 'blur_settings.dart';
import 'profile.dart';
import 'subscription.dart';

class StandartUserBottom extends StatefulWidget {
  const StandartUserBottom({super.key});

  @override
  State<StandartUserBottom> createState() => _StandartUserBottomState();
}

class _StandartUserBottomState extends State<StandartUserBottom> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;

  final List<Widget> _screens = const [
    HomeScreen(),
    SubscriptionScreen(),
    BlurSettingsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedIcon(IconData icon, bool isActive) {
    if (!isActive) return Icon(icon, size: 28);
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        double angle = 0.3 * (1 - _controller.value * 2);
        return Transform.rotate(
          angle: angle,
          child: Icon(icon, size: 28),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: _buildAnimatedIcon(Icons.home, _currentIndex == 0),
            title: const Text("Accueil"),
            selectedColor:AppColors.primary,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: _buildAnimatedIcon(Icons.workspace_premium, _currentIndex == 1),
            title: const Text("Premium"),
             selectedColor:AppColors.primary,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: _buildAnimatedIcon(Icons.tune, _currentIndex == 2),
            title: const Text("Réglages"),
            selectedColor:AppColors.primary,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: _buildAnimatedIcon(Icons.person, _currentIndex == 3),
            title: const Text("Profil"),
             selectedColor:AppColors.primary,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}