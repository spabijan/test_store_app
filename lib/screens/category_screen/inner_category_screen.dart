import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/controllers/providers/category_item_provider.dart';
import 'package:test_store_app/views/screens/deatil/inner_category_screen/widgets/inner_banner_widget.dart';
import 'package:test_store_app/views/widgets/header_widget.dart';

class InnerCategoryScreen extends ConsumerStatefulWidget {
  const InnerCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends ConsumerState<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryItemProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
            child: Stack(
              children: [
                const HeaderWidget(),
                Positioned(
                  left: 4,
                  top: 68,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [InnerBannerScreen(imageUrl: category.banner)],
          ),
        ));
  }
}
