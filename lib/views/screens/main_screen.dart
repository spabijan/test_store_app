import 'package:flutter/material.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/views/screens/root_screens/account_screen.dart';
import 'package:test_store_app/views/screens/root_screens/cart_screen.dart';
import 'package:test_store_app/views/screens/root_screens/favorite_screen.dart';
import 'package:test_store_app/views/screens/root_screens/home_screen.dart';
import 'package:test_store_app/views/screens/root_screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  Widget _getScreen(int index) {
    final Widget result = switch (index) {
      0 => const HomeScreen(),
      1 => const FavoriteScreen(),
      2 => const StoresScreen(),
      3 => const CartScreen(),
      4 => const AccountScreen(),
      _ => throw UnimplementedError(),
    };
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (tappedIndex) => setState(() => _pageIndex = tappedIndex),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(AssetIcons.home, width: 25), label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(AssetIcons.love, width: 25), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Image.asset(AssetIcons.mart, width: 25), label: 'Stores'),
          BottomNavigationBarItem(
              icon: Image.asset(AssetIcons.cart, width: 25), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Image.asset(AssetIcons.user, width: 25), label: 'Account'),
        ],
      ),
    );
  }
}
