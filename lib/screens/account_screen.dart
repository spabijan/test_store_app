import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';
import 'package:test_store_app/screens/widgets/header_widget.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
          child: const HeaderWidget()),
      body: Center(
          child: Column(
        children: [
          const Text('Account Screen'),
          ElevatedButton(
              onPressed: () {
                ref.watch(authProvider.notifier).logoutUser();
                GoRouter.of(context).goNamed(RouteNames.signin);
              },
              child: const Text('Signout'))
        ],
      )),
      bottomNavigationBar: NavigationTapBar(),
    );
  }
}
