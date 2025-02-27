import 'package:flutter/material.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationTapBar(),
        body: const Center(child: Text('Favorites Screen')));
  }
}
