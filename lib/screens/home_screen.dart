import 'package:flutter/material.dart';
import 'package:test_store_app/screens/components/banner/banners_list_widget.dart';
import 'package:test_store_app/screens/category_screen/components/category_list_widget.dart';
import 'package:test_store_app/screens/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [HeaderWidget(), BannerListWidget(), CategoryListWidget()],
      ),
    ));
  }
}
