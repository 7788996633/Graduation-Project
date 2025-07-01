import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../../constant.dart';
import 'user_home_screen.dart';


class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _MainClientPageState();
}

class _MainClientPageState extends State<UserHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserHomeScreen(),
    const FavoritesScreen(),
    const LegalNewsScreen(),
  ];

  final List<Widget> _items = [
    const Icon(Icons.home, size: 30),
    const Icon(Icons.favorite, size: 30),
    const Icon(Icons.newspaper, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:AppColors.white,
        color: AppColors.darkBlue ,
        buttonBackgroundColor: AppColors.white,
        height: 60,
        items: _items,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Text(
          'Your favorite cases and documents will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class LegalNewsScreen extends StatelessWidget {
  const LegalNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal News'),
      ),
      body: const Center(
        child: Text(
          'Latest legal news and updates will be shown here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
