import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:test_store_app/screens/category_screen/providers/category_provider.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/account_screen.dart';
import 'package:test_store_app/screens/cart_screen.dart';
import 'package:test_store_app/screens/category_screen/category_screen.dart';
import 'package:test_store_app/screens/favorite_screen.dart';
import 'package:test_store_app/screens/home_screen.dart';
import 'package:test_store_app/screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final UnmodifiableListView _pages = UnmodifiableListView([
    const HomeScreen(),
    const FavoriteScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const AccountScreen(),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
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
          const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categories'),
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
