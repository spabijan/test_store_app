import 'package:flutter/material.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('CartScreen')),
      bottomNavigationBar: NavigationTapBar(),
    );
  }
}
