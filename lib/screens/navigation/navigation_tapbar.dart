import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/navigation/provider/selected_index_provider.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';

class NavigationTapBar extends ConsumerWidget {
  NavigationTapBar({super.key});

  final UnmodifiableListView _pages = UnmodifiableListView([
    RouteNames.home,
    RouteNames.favourites,
    RouteNames.category,
    RouteNames.stores,
    RouteNames.cart,
    RouteNames.account
  ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var actualPage = ref.watch(selectedPageIndexProvider);
    return BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: actualPage,
        onTap: (tappedIndex) {
          ref.read(selectedPageIndexProvider.notifier).state = tappedIndex;
          GoRouter.of(context).goNamed(_pages[tappedIndex]);
        },
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
        ]);
  }
}
