import 'package:flutter/material.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Account Screen')),
      bottomNavigationBar: NavigationTapBar(),
    );
  }
}
