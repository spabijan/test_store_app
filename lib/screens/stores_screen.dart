import 'package:flutter/material.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationTapBar(),
        body: const Center(child: Text('Stores Screen')));
  }
}
